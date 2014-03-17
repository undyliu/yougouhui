(ns yougou.activity
  (:use 
		[korma.core]
		[yougou.db]
		)
)

(defn get-activities [channel-id]
   (if (= channel-id "0")
	(select activities 
	  (with channels)
		(fields :uuid :img :title :price :discount :visit_count :discuss_count :content :channel_id [:e_channel.name :channel_name]) 
					(order :publish_time)) 
	(select activities
	  (with channels) 
		(fields :uuid :img :title :price :discount :visit_count :discuss_count [:e_channel.name :channel_name]) 
					(where {:channel_id [= channel-id]}) 
					(order :publish_time))
   )	
)

(defn get-activity-discusses [activity-id]
  (select discusses (where {:activity_id activity-id})
  )
)

(defn get-activity-data [id]
  (let [[activity] (select activities (where {:uuid id}))
       discusses (get-activity-discusses id)
	]
   (assoc activity :discusses discusses)
  )
)


