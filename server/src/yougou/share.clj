(ns yougou.share
  (:use 
		[korma.core]
		[yougou.db]
		)
	(:require
		[yougou.file :as file]
	)
)

(defn get-deleted-shares [min-pub-time]
  (let [publish-time (Long/valueOf min-pub-time)]
    (if (< publish-time 0)
      {}
      (select shares (fields :uuid) (where {:publish_time [>= publish-time] :is_deleted [= 1]}))
    )
  )
)

(defn get-deleted-comments [min-pub-time]
  (let [publish-time (Long/valueOf min-pub-time)]
    (if (< publish-time 0)
      {}
      (select comments (fields :uuid) (where {:publish_time [>= publish-time] :is_deleted [= 1]}))
    )
  )
)

(defn get-newest-comments [last-pub-time]
  (let [publish-time (Long/valueOf last-pub-time)]
    (if (< publish-time 0)
        {}
	(select comments (where {:publish_time [> publish-time] :is_deleted [not= 1]}))
    )
  )
)

(defn get-friend-shares [last-pub-time]
  (let [publish-time (Long/valueOf last-pub-time)]
    (if (< publish-time 0)
        {}
  	(select shares (fields :uuid :content :publisher :publish_time :activity_id)
	       (where {:publish_time [> publish-time] :is_deleted [not= 1]})
		(order :publish_time)
	)
     )
  )
)

(defn get-share-images [share-id]
  (select share-images (where {:share_id share-id})
  )
)

(defn get-comments [share-id]
  (select comments (where {:share_id share-id :is_deleted [not= 1]})
  )
)

(defn get-newest-share-data [last-pub-time]
  (let [shares (get-friend-shares last-pub-time)
				first-share (first shares)
			 ]
		(loop [share-list shares
					share first-share
					result []
					]
				(if (== 0 (count share-list))
					result
				(recur (rest share-list)
						 (first (rest share-list))
						(conj result 
							(assoc 
								(assoc share :images 
										(get-share-images (:uuid share))) 
										:comments (get-comments (:uuid share)))))
				)
		)
	)
)

(defn get-friend-share-data [last-pub-time min-pub-time last-comm-pub-time min-comm-pub-time]
  {:newest-shares (get-newest-share-data last-pub-time)
   :newest-comments (get-newest-comments last-comm-pub-time)
   :deleted-shares (get-deleted-shares min-pub-time)
   :deleted-comments (get-deleted-comments min-comm-pub-time)
  }
)

(defn save-share-img [share-id img-name req-params ord-index]
	(let [ uuid (str (java.util.UUID/randomUUID))
			]
		(when (and img-name (> (count (clojure.string/trim img-name)) 0))	
			(insert share-images (values {:uuid uuid :img img-name :share_id share-id :ord_index ord-index}))
			(file/save-image-file img-name (:tempfile (req-params img-name)))
		)
	uuid)
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
							(conj result (save-share-img share-id img-name req-params ord-index))
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
			]
		;(println publisher)
		;;(transaction	
			(insert shares (values {:uuid uuid :content content :publisher publisher :publish_time (str  (System/currentTimeMillis))}))
			(if image-names
				(save-share-imgs uuid (clojure.string/split image-names #"[|]") req-params)
			)
		;;)
	{:uuid uuid})
)

(defn save-comment [share-id content publisher]
	(let [uuid (str (java.util.UUID/randomUUID))
				publish-time (str  (System/currentTimeMillis))
			]
			(insert comments (values {:uuid uuid :share_id share-id :content content :publisher publisher :publish_time publish-time}))
	{:uuid uuid :publish_time publish-time})
)

(defn del-share [share-id]
	(if share-id
		;(delete shares (where {:uuid share-id}))
		(update shares (set-fields {:is_deleted 1}) (where {:uuid share-id}))
	)
)

(defn del-share-img [share-id]
	(when share-id
		(delete share-images (where {:share_id share-id}))
		(file/del-image-files (select share-images (fields :img) (where {:share_id share-id})))
	)
)

(defn del-comments [share-id]
	;(delete comments (where {:share_id share-id}))
	(update comments (set-fields {:is_deleted 1}) (where {:share_id share-id}))
)

(defn del-share-data [share-id]
	(when share-id
		(del-share share-id)
		(del-share-img share-id)
		(del-comments share-id)
	{:uuid share-id})
)

(defn del-comment [comment-id]
	(if comment-id
		;(delete comments (where {:uuid comment-id}))
		(update comments (set-fields {:is_deleted 1}) (where {:uuid comment-id}))
	)
	{:uuid comment-id}
)