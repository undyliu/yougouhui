(ns yougou.share
  (:use
		[korma.core]
    [korma.db]
		[yougou.db]
		)
	(:require
		[yougou.file :as file]
		[yougou.date :as date]
    [yougou.user :as user]
    [yougou.shop :as shop]
    [yougou.message :as message]
	)
)

(def share-select-base
  (-> (select* shares)
      (fields :uuid :content :publisher :publish_time :publish_date :sale_id :shop_id [:e_shop.name :shop_name] :is_deleted :access_type)
      (join :left shops (= :e_shop.uuid :shop_id))
  )
)

(defn- get-share-images [update-time share-id]
  (select share-images (where (if update-time {:share_id share-id :last_modify_time [> update-time]} {:share_id share-id}))
  )
)

(defn- get-comments [update-time share-id]
  (select share-comments
          (fields :uuid :content :is_deleted :last_modify_time :publish_time :share_id
                  :publisher :e_user.name :e_user.type :e_user.photo :e_user.phone :e_user.register_time)
          (join users (= :e_user.uuid :publisher))
          (where (if update-time {:share_id share-id :last_modify_time [> update-time]} {:share_id share-id}))
  )
)

(defn- get-shop-reply [share-id]
  (if-let [reply (first (select share-shop-replies (where {:share_id share-id}) ))]
    reply
    {}
   )
  )

(defn- get-friend-shares [last-pub-time user-id]
  (let [publish-time (Long/valueOf last-pub-time)]
    (if (< publish-time 0)
       {}
			(exec (-> share-select-base
							(where {:last_modify_time [> publish-time]})
							(where (or {:publisher user-id} {:publisher [in (subselect friends (fields :friend_id) (where {:user_id user-id}))]}))
							(order :publish_time)
						)
			)
    )
  )
)

(defn- assemble-share-data [shares update-time]
  (loop [share-list shares
					share (first shares)
					result []
					]
				(if (== 0 (count share-list))
					result
          (let [rest-shares (rest share-list)
                is-del (= 1 (:is_deleted share))
                share-id (:uuid share)
                ]
            (recur rest-shares
                   (first rest-shares)
                   (if is-del
                     (conj result share)
                     (conj result
                           (assoc share :images (get-share-images update-time share-id)
                             :comments (get-comments update-time share-id)
                             :user (user/get-user-without-pwd (:publisher share))
                             :shop (shop/get-shop (:shop_id share))
                             :shop_reply (get-shop-reply share-id)))
                     )
					    )
            )
				  )
		  )
  )

(defn get-friend-share-data [update-time user-id]
  (assemble-share-data (get-friend-shares update-time user-id) update-time)
  )

(defn- save-share-img [share-id img-name req-params ord-index]
	(let [ uuid (str (java.util.UUID/randomUUID))
			]
		(when (and img-name (> (count (clojure.string/trim img-name)) 0))
			(insert share-images (values {:uuid uuid :img img-name :share_id share-id :ord_index ord-index :last_modify_time (str (System/currentTimeMillis))}))
			(file/save-image-file img-name (:tempfile (req-params img-name)))
		)
	  {:uuid uuid :img img-name}
    )
)

(defn- save-share-imgs [share-id image-names req-params]
	(let [first-img-name (first image-names)
				index 1
			]
		(loop [name-list image-names
				  img-name first-img-name
					ord-index index
					result []
					]

				(if (== (count name-list) 0)
					 result
					(recur (rest name-list)
                 (first (rest name-list))
                 (inc ord-index)
                 (if (and img-name (> (count (clojure.string/trim img-name)) 0))
                   (conj result (save-share-img share-id img-name req-params ord-index))
                   result
                   )
					)
				)
		)
	)
)

(defn save-share [req-params]
	(let [uuid (str (java.util.UUID/randomUUID))
				content (java.net.URLDecoder/decode (:content req-params) "utf-8")
				image-names (java.net.URLDecoder/decode (:fileNameList req-params) "utf-8")
			  publisher (:publisher req-params)
        shop-id (:shop_id req-params)
				current-time (System/currentTimeMillis)
        access-type (:access_type req-params)
        share {:uuid uuid :publish_time current-time :publish_date (date/formatDate current-time)}
			]

		  (transaction
			  (insert shares (values {:uuid uuid :content content :shop_id shop-id :publisher publisher :publish_time current-time
                                :publish_date (date/formatDate current-time) :last_modify_time current-time :access_type access-type}))
			  (user/inc-user-share-count publisher)
      )
      (if image-names
				(assoc share :images (save-share-imgs uuid (clojure.string/split image-names #"[|]") req-params))
        share
			)
      (if shop-id
        (assoc share :shop (shop/get-shop shop-id))
        )
  )
)

(defn save-comment [share-id content publisher]
	(let [uuid (str (java.util.UUID/randomUUID))
				publish-time (str (System/currentTimeMillis))
			]
    (transaction
		  (insert share-comments (values {:uuid uuid :share_id share-id :content content :publisher publisher :publish_time publish-time :last_modify_time publish-time}))
      (update shares (set-fields {:last_modify_time publish-time})
            (where {:uuid [in (subselect share-comments (fields :share_id) (where {:e_share_comment.uuid uuid}))]}))
     )
	  {:uuid uuid :publish_time publish-time})
)

(defn- del-share [share-id]
	(when share-id
		  (update shares (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid share-id}))
      (user/des-user-share-count (:publisher (first (select shares (fields :publisher) (where {:uuid share-id})))))
	)
)

(defn- del-share-img [share-id]
	(when share-id
		(file/del-image-files (select share-images (fields :img) (where {:share_id share-id})))
		(delete share-images (where {:share_id share-id}))
	)
)

(defn- del-comments [share-id]
	(update share-comments (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
          (where {:share_id share-id}))
)

(defn del-share-data [share-id]
	(when share-id
    (transaction
		  (del-share share-id)
		  (del-share-img share-id)
		  (del-comments share-id)
     )
	  {:uuid share-id})
)

(defn del-comment [comment-id]
	(when comment-id
    (transaction
		  (update share-comments (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid comment-id}))
      (update shares (set-fields {:last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid [in (subselect share-comments (fields :share_id) (where {:e_share_comment.uuid comment-id}))]}))
     )
	)
	{:uuid comment-id}
)

(defn- get-shares-by-publisher [user-id]
  (exec (-> share-select-base
            (where {:publisher user-id}))
        )
  )

(defn get-user-share-data [user-id]
  (assemble-share-data (get-shares-by-publisher user-id) nil)
 )

(defn- get-shop-shares [shop-id update-time]
  (exec (-> share-select-base
            (where {:shop_id shop-id :last_modify_time [> update-time]})
          )
   )
  )

(defn get-shop-share-data [shop-id update-time]
  (assemble-share-data (get-shop-shares shop-id update-time) update-time)
  )

(defn save-share-shop-reply [share-id shop-id content grade replier]
  (let [uuid (str (java.util.UUID/randomUUID))
				reply-time (str (System/currentTimeMillis))]
    (transaction
      (insert share-shop-replies (values {:uuid uuid :shop_id shop-id :share_id share-id :status "1"
                                        :content content :grade grade :replier replier :reply_time reply-time }))
      (when-let [publisher (:publisher (first (select shares (fields :publisher) (where {:uuid share-id}))))]
        (user/update-user-grade-amount publisher grade)
        (user/save-user-grade publisher shop-id share-id replier grade)
        (message/save-message replier shop-id publisher (str "购物晒单-奖励积分:" grade "\n商家回馈:" content))
        )
      {:uuid uuid :reply_time reply-time :status "1"}
     )
    )
  )
