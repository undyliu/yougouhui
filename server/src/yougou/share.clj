(ns yougou.share
  (:use
		[korma.core]
		[yougou.db]
		)
	(:require
		[yougou.file :as file]
		[yougou.date :as date]
	)
)

(defn get-share-images [update-time share-id]
  (select share-images (where {:share_id share-id :last_modify_time [> update-time]})
  )
)

(defn get-comments [update-time share-id]
  (select share-comments (where {:share_id share-id :last_modify_time [> update-time]})
  )
)

(defn get-friend-shares [last-pub-time user-id]
  (let [publish-time (Long/valueOf last-pub-time)]
    (if (< publish-time 0)
       {}
			(exec (-> (select* shares)
							(fields :uuid :content :publisher :publish_time :publish_date :sale_id :shop_id :is_deleted)
							(where {:last_modify_time [> publish-time]})
							(where (or {:publisher user-id} {:publisher [in (subselect friends (fields :friend_id) (where {:user_id user-id}))]}))
							(order :publish_time)
						)
			)
    )
  )
)

(defn get-friend-share-data [update-time user-id]
  (let [shares (get-friend-shares update-time user-id)
				first-share (first shares)
			 ]
		(loop [share-list shares
					share first-share
					result []
					]
				(if (== 0 (count share-list))
					result
          (let [rest-shares (rest share-list)
                is-del (= 1 (:is_deleted share))
                ]
            (recur rest-shares
                   (first rest-shares)
                   (if is-del
                     (conj result share)
                     (conj result
                           (assoc share :images (get-share-images update-time (:uuid share))
                             :comments (get-comments update-time (:uuid share))))
                     )
					    )
            )
				  )
		  )
	  )
  )

(defn save-share-img [share-id img-name req-params ord-index]
	(let [ uuid (str (java.util.UUID/randomUUID))
			]
		(when (and img-name (> (count (clojure.string/trim img-name)) 0))
			(insert share-images (values {:uuid uuid :img img-name :share_id share-id :ord_index ord-index :last_modify_time (str (System/currentTimeMillis))}))
			(file/save-image-file img-name (:tempfile (req-params img-name)))
		)
	  {:uuid uuid :img img-name}
    )
)

(defn save-share-imgs [share-id image-names req-params]
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
        share {:uuid uuid :publish_time current-time :publish_date (date/formatDate current-time)}
			]
		;(println publisher)
		;;(transaction
			(insert shares (values {:uuid uuid :content content :shop_id shop-id :publisher publisher :publish_time current-time :publish_date (date/formatDate current-time) :last_modify_time current-time}))
			(if image-names
				(assoc share :images (save-share-imgs uuid (clojure.string/split image-names #"[|]") req-params))
        share
			)
		;;)
  )
)

(defn save-comment [share-id content publisher]
	(let [uuid (str (java.util.UUID/randomUUID))
				publish-time (str (System/currentTimeMillis))
			]
		(insert share-comments (values {:uuid uuid :share_id share-id :content content :publisher publisher :publish_time publish-time :last_modify_time publish-time}))
    (update shares (set-fields {:last_modify_time publish-time})
            (where {:uuid [in (subselect share-comments (fields :share_id) (where {:e_share_comment.uuid uuid}))]}))
	  {:uuid uuid :publish_time publish-time})
)

(defn del-share [share-id]
	(if share-id
		;(delete shares (where {:uuid share-id}))
		(update shares (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid share-id}))
	)
)

(defn del-share-img [share-id]
	(when share-id
		(file/del-image-files (select share-images (fields :img) (where {:share_id share-id})))
		(delete share-images (where {:share_id share-id}))
	)
)

(defn del-comments [share-id]
	(update share-comments (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
          (where {:share_id share-id}))
)

(defn del-share-data [share-id]
	(when share-id
		(del-share share-id)
		(del-share-img share-id)
		(del-comments share-id)
	{:uuid share-id})
)

(defn del-comment [comment-id]
	(when comment-id
		(update share-comments (set-fields {:is_deleted 1 :last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid comment-id}))
    (update shares (set-fields {:last_modify_time (str (System/currentTimeMillis))})
            (where {:uuid [in (subselect share-comments (fields :share_id) (where {:e_share_comment.uuid comment-id}))]}))
	)
	{:uuid comment-id}
)

(defn get-shares-by-shop [shop-id]
  (
   )
  )
