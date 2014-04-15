(ns yougou.sale
  (:use
		[korma.core]
		[yougou.db]
		)
  (:require
		[yougou.file :as file]
    [yougou.date :as date]
    [yougou.shop :as shop]
	)
)

(def sale-select-base
  (-> (select* sales)
      (fields :uuid :title :content :img :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name] :trade_id :publisher :publish_time :publish_date :e_mapping_ct.channel_id)
      (join channel-trades (= :e_mapping_ct.trade_id :trade_id))
      (join shops (= :e_shop.uuid :shop_id))
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

(defn save-sale-visit [user-id sale-id visit-count]
  (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
    (update sales (set-fields {:visit_count visit-count}) (where {:uuid sale-id}))
    (insert sale-visites (values {:uuid uuid :user_id user-id :sale_id sale-id :visit_time currentTime}))
    )
  )

(defn get-sale-images [sale-id]
  (select sale-images (fields :uuid :img :ord_index) (where {:sale_id sale-id}))
  )

(defn get-sale-discusses [sale-id]
  (select sale-discusses (where {:sale_id sale-id})
  )
)

(defn get-sale-data [id user-id]
  (let [[sale] (exec (-> sale-select-base (where {:uuid id})))
         discusses (get-sale-discusses id)
         images (get-sale-images id)
         ;shop (shop/get-shop (:shop_id sale))
	    ]
    (save-sale-visit user-id id (+ 1 (:visit_count sale)))
    (assoc sale :discusses discusses :images images )
  )
)

(defn save-sale [title content start-date end-date shop-id trade-id publisher image]
  (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
    (insert sales (values {:uuid uuid :title title :content content :start_date start-date :end_date end-date :shop_id shop-id :trade_id trade-id :publisher publisher :publish_time currentTime :publish_date (date/formatDate currentTime) :img image}))
    {:uuid uuid :publish_time currentTime :publish_date (date/formatDate currentTime) :img image :status 0}
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

(defn save-sale-favorit [user-id sale-id]
  (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
    (insert sale-favorites (values {:uuid uuid :user_id user-id :sale_id sale-id :last_modify_time currentTime}))
    {:uuid uuid :last_modify_time currentTime}
    )
  )

(defn save-sale-discuss [sale-id publisher content]
  (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        discuss-count (:discuss_count (first (select sales (fields :discuss_count) (where {:uuid sale-id}))))
        ]
    (insert sale-discusses (values {:uuid uuid :sale_id sale-id :content content :publisher publisher :publish_time currentTime}))
    (update sales (set-fields {:discuss_count (+ 1 discuss-count)}) (where {:uuid sale-id}))
    {:uuid uuid :publish_time currentTime}
   )
 )

(defn del-sale-discuss [uuid]
  (let [sale (first (select sales (fields :discuss_count :uuid)
                                  (join sale-discusses (and (= :e_sale_discuss.sale_id :uuid) (= :e_sale_discuss.uuid uuid)))
                                  ))
        discuss-count (:discuss_count sale)
        sale-id (:uuid sale)
        ]
    (update sale-discusses (set-fields {:is_deleted 1}) (where {:uuid uuid}))
    (update sales (set-fields {:discuss_count (- discuss-count 1)}) (where {:uuid sale-id}))
    {:uuid uuid :is_deleted 1}
    )
  )

(defn get-sale-discusses [sale-id]
  (let [discusses (select sale-discusses
                          (fields :uuid :sale_id :content :publisher :publish_time)
                          (where {:is_deleted 0}))
        ]
    discusses
   )
  )
