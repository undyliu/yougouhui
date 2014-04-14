(ns yougou.sale
  (:use
		[korma.core]
		[yougou.db]
		)
  (:require
		[yougou.file :as file]
    [yougou.date :as date]
	)
)

(def sale-select-base
  (-> (select* sales)
      (fields :uuid :title :content :img :start_date :end_date :visit_count :discuss_count :shop_id :trade_id :publisher :publish_time :publish_date)
  )
)

(defn get-sales-by-channel [channel-id]
  ;(select sales
   ;       (with shops)
    ;      (fields :uuid :title :content :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name])
          ;(if (not= channel-id 0)
          ;  (where {:trade_id [in (subselect channel-trades (fields :trade_id) (where {:channel_id channel-id}))]})
          ; )
     ;     (order :publish_time)
   ;)
  (exec (-> sale-select-base
            (order :publish_time)
         )
   )
)

(defn get-sales-by-shop [shop-id]
  (exec (-> sale-select-base
            (where {:shop_id shop-id})
         )
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

(defn save-sale [title content start-date end-date shop-id trade-id publisher image]
  (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
    (insert sales (values {:uuid uuid :title title :content content :start_date start-date :end_date end-date :shop_id shop-id :trade_id trade-id :publisher publisher :publish_time currentTime :publish_date (date/formatDate currentTime) :img image}))
    {:uuid uuid :publish_time currentTime :status 0}
    )
  )

(defn save-sale-images [sale-id image-names files]
  (loop [name-list image-names ord-index 0 result []
         ]
    (if (= 0 (count name-list))
      result
      (let [file-name (first name-list)]
        (if file-name
          (let [uuid (str (java.util.UUID/randomUUID))]
            (insert sale-images (values {:uuid uuid :sale_id sale-id :img file-name :ord_index ord-index}))
            (file/save-image-file file-name (:tempfile (files file-name)))
            (recur (rest name-list) (inc ord-index) (conj result {:uuid uuid :img file-name :ord_index ord-index}))
           )
         )
       )
     )
    )
 )

(defn save-sale-data [title content start-date end-date shop-id trade-id publisher image-names files]
  (let [sale (save-sale title content start-date end-date shop-id trade-id publisher (first image-names))
        images (save-sale-images (:uuid sale) image-names files)
        ]
    (assoc sale :images images)
    )
  )


