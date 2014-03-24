(ns yougou.share
  (:use 
		[korma.core]
		[yougou.db]
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