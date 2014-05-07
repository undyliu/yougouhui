(ns yougou.sale
  (:use
		[korma.core]
    [korma.db]
		[yougou.db]
		)
  (:require
		[yougou.file :as file]
    [yougou.date :as date]
    [yougou.shop :as shop]
    [yougou.user :as user]
	)
)

(defn get-sales-by-distance [lat lon dist offset-val]
  (exec (-> (select* sales)
            (fields :uuid :title :content :img :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name]
                    :e_shop.location :trade_id :publisher :publish_time :publish_date [:e_mapping_ct.channel_id :channel_id] :status
                    [(sqlfn geodist_field lat lon :e_shop.latitude :e_shop.longitude) :distance])
            (join :inner channel-trades (and (= :e_mapping_ct.trade_id :trade_id) (not= :e_mapping_ct.channel_id nil)))
            (join :inner shops (and (= :e_shop.uuid :shop_id)
                                    (< :e_shop.latitude (+ lat 1)) (> :e_shop.latitude (- lat 1))
                                    (< :e_shop.longitude (+ lon 1)) (> :e_shop.longitude (- lon 1))
                                    ))
            (where {:status "1"})
            (having {:distance [<= dist]})
            (order :distance)
            (limit def-page-size)
            (offset offset-val)
         )
   )
  )

(def sale-select-base
  ;(println
  (-> (select* sales)
      (fields :uuid :title :content :img :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name] :e_shop.location :trade_id :publisher :publish_time :publish_date [:e_mapping_ct.channel_id :channel_id] :status)
      (join :inner channel-trades (and (= :e_mapping_ct.trade_id :trade_id) (not= :e_mapping_ct.channel_id nil)))
      (join :inner shops (= :e_shop.uuid :shop_id))
      ;(as-sql)
  )
   ;)
)

;此函数抽象的不够，需重构
(defn get-sales-by-channel [channel-id update-time]
  (if (= channel-id "0");全部
    (exec (-> sale-select-base
            (where {:status (if (< update-time 0) [= "1"] [not= "0"])})
            (where {:last_modify_time [> update-time]})
            (order :publish_time)
         )
     )
    (exec (-> (select* sales)
            (fields :uuid :title :content :img :start_date :end_date :visit_count :discuss_count :shop_id [:e_shop.name :shop_name] :e_shop.location :trade_id :publisher :publish_time :publish_date :e_mapping_ct.channel_id :status)
            (join :inner channel-trades (and (= :e_mapping_ct.trade_id :trade_id) (= :e_mapping_ct.channel_id channel-id)))
            (join :inner shops (= :e_shop.uuid :shop_id))
            (where {:status (if (< update-time 0) [= "1"] [not= "0"])})
            (where {:last_modify_time [> update-time]})
            (order :publish_time)
          )
     )
    )
)

(defn get-sales-by-shop [shop-id update-time]
  (exec (-> sale-select-base
            (where {:shop_id shop-id})
            (where {:last_modify_time [> update-time]})
         )
        )
  )

(defn- save-sale-visit [user-id sale-id]
  (let [uuid (str (java.util.UUID/randomUUID))
        current-time (System/currentTimeMillis)
        ]
    (transaction
      (exec-raw [" update e_sale set visit_count = visit_count + 1, last_modify_time = ? where uuid = ?" [current-time, sale-id]])
      (insert sale-visites (values {:uuid uuid :user_id user-id :sale_id sale-id :visit_time current-time}))
     )
    )
  )

(defn- get-sale-images [sale-id]
  (select sale-images (fields :uuid :img :ord_index) (where {:sale_id sale-id}))
  )

(defn get-sale-discusses [sale-id update-time]
  (select sale-discusses
          (fields :uuid :content :sale_id :is_deleted :publisher :publish_time [:e_user.name :user_name] :e_user.phone :e_user.photo)
          (join users (= :e_user.uuid :publisher))
          (where {:sale_id sale-id :last_modify_time [> update-time]})
  )
)

;评论和商铺数据单独获取
(defn get-sale-data [id user-id]
  (let [[sale] (exec (-> sale-select-base (where {:uuid id})))
         ;discusses (get-sale-discusses id)
         images (get-sale-images id)
         ;shop (shop/get-shop (:shop_id sale))
	    ]
    (save-sale-visit user-id id)
    (assoc sale :images images)
  )
)

(defn- save-sale [title content start-date end-date shop-id trade-id publisher image]
  (let [uuid (str (java.util.UUID/randomUUID))
        current-time (System/currentTimeMillis)
        ]
    (insert sales (values {:uuid uuid :title title :content content :start_date start-date :end_date end-date :shop_id shop-id :trade_id trade-id :publisher publisher :publish_time current-time :publish_date (date/formatDate current-time) :img image :last_modify_time current-time}))
    {:uuid uuid :publish_time current-time :publish_date (date/formatDate current-time) :img image :status 0}
    )
  )

(defn- save-sale-images [sale-id image-names files]
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
  (transaction
    (let [sale (save-sale title content start-date end-date shop-id trade-id publisher (first image-names))
        images (save-sale-images (:uuid sale) image-names files)
        ]
      (assoc sale :images images)
      )
   )
  )

(defn save-sale-discuss [sale-id publisher content]
  (let [uuid (str (java.util.UUID/randomUUID))
        current-time (System/currentTimeMillis)
        ]
    (transaction
      (insert sale-discusses (values {:uuid uuid :sale_id sale-id :content content :publisher publisher :publish_time current-time :last_modify_time current-time}))
      (exec-raw ["update e_sale set discuss_count = discuss_count + 1, last_modify_time = ? where uuid = ?" [current-time, sale-id]])
      (user/inc-user-sale-dis-count publisher)
    )
    {:uuid uuid :publish_time current-time}
   )
 )

(defn del-sale-discuss [uuid]
  (let [sale (first (select sales (fields :discuss_count :uuid)
                                  (join sale-discusses (and (= :e_sale_discuss.sale_id :uuid) (= :e_sale_discuss.uuid uuid)))
                                  ))
        sale-id (:uuid sale)
        current-time (System/currentTimeMillis)
        ]
    (transaction
      (update sale-discusses (set-fields {:is_deleted 1 :last_modify_time current-time}) (where {:uuid uuid}))
      (exec-raw ["update e_sale set discuss_count = discuss_count + 1, last_modify_time = ? where uuid = ?" [current-time, sale-id]])
      (user/des-user-sale-dis-count (:publisher (first (select sale-discusses (fields :publisher) (where {:uuid uuid})))))
     )
    {:uuid uuid :is_deleted 1}
    )
  )

(defn cancel-sale [sale-id]
  (update sales (set-fields {:status 2 :last_modify_time (System/currentTimeMillis)}) (where {:uuid sale-id}))
  )
