(ns yougou.share
  (:use 
		[korma.core]
		[yougou.db]
		)
	(:require
		[yougou.file :as file]
	)
)

(defn get-friend-shares []
  (select shares (fields :uuid :content :publisher :publish_time :activity_id)
		(order :publish_time)
  )
)

(defn get-share-images [share-id]
  (select share-images (where {:share_id share-id})
  )
)

(defn get-comments [share-id]
  (select comments (where {:share_id share-id})
  )
)

(defn get-friend-share-data []
  (let [shares (get-friend-shares)
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

(defn save-share-img [share-id img-name req-params ord-index]
	(let [ uuid (str (java.util.UUID/randomUUID))
			]
		(when (and img-name (> (count (clojure.string/trim img-name)) 0))	
			(insert share-images (values {:uuid uuid :img img-name :share_id share-id :ord_index ord-index}))
			(file/save-image-file img-name (:tempfile (req-params img-name)))
		)
	)
)

(defn save-share-imgs [share-id image-names req-params]
	(let [first-img-name (first image-names)
				index 1
			]
		(loop [name-list image-names
				  img-name first-img-name
					ord-index index
					]
			  		
				(when (> (count name-list) 0)
					(save-share-img share-id img-name req-params ord-index)
					(recur (rest name-list)
							(first (rest name-list))
							(inc ord-index)
					)
				)
			
		)
	)			
)

(defn save-share [req-params]
	(let [uuid (str (java.util.UUID/randomUUID))
				content (java.net.URLDecoder/decode (:content req-params) "utf-8")
				image-names (java.net.URLDecoder/decode (:fileNameList req-params) "utf-8")
			]
		;;(transaction	
			(insert shares (values {:uuid uuid :content content :publish_time (str  (System/currentTimeMillis))}))
			(if image-names
				(save-share-imgs uuid (clojure.string/split image-names #"[|]") req-params)
			)
		;;)
	)
)

