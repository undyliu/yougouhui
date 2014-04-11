(ns yougou.sale
  (:use
		[korma.core]
		[yougou.db]
		)
)

(defn get-sales [channel-id]
  (select sales
          (with shops)
          (fields :uuid :title :content :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name])
          ;(if (not= channel-id 0)
          ;  (where {:trade_id [in (subselect channel-trades (fields :trade_id) (where {:channel_id channel-id}))]})
          ; )
          (order :publish_time)
   )
)

(defn get-sale-discusses [sale-id]
  (select sale-discusses (where {:sale_id sale-id})
  )
)

(defn get-sale-data [id]
  (let [[sale] (select sales (where {:uuid id}))
       discusses (get-sale-discusses id)
	]
   (assoc sale :discusses discusses)
  )
)


