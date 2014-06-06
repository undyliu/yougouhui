(ns yougou.favorit
  (:use
		[korma.core]
		[yougou.db]
		)
)

(defn save-sale-favorit [user-id sale-id]
  (if-let [favorit (first (select sale-favorites (fields :uuid :last_modify_time) (where {:sale_id sale-id :user_id user-id})))]
    favorit
    (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
      (insert sale-favorites (values {:uuid uuid :user_id user-id :sale_id sale-id :last_modify_time currentTime}))
      {:uuid uuid :last_modify_time currentTime}
    )
    )
  )

(defn save-shop-favorit [user-id shop-id]
  (if-let [favorit (first (select shop-favorites (fields :uuid :last_modify_time) (where {:shop_id shop-id :user_id user-id})))]
     favorit
     (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
        ]
      (insert shop-favorites (values {:uuid uuid :user_id user-id :shop_id shop-id :last_modify_time currentTime}))
      {:uuid uuid :last_modify_time currentTime}
    )
   )
  )

(defn del-sale-favorit [user-id sale-id]
  (delete sale-favorites (where {:user_id user-id :sale_id sale-id}))
  {:is_deleted "1"}
 )

(defn del-shop-favorit [user-id shop-id]
  (delete shop-favorites (where {:user_id user-id :shop_id shop-id}))
  {:is_deleted "1"}
  )

(defn get-sale-favorites-by-user [user-id]
  (select sale-favorites
          (fields :uuid :sale_id :user_id :last_modify_time :e_sale.title :e_sale.img)
          (join sales (= :e_sale.uuid :sale_id))
          (where {:user_id user-id}))
 )

(defn get-shop-favorites-by-user [user-id]
  (select shop-favorites
          (fields :uuid :shop_id :user_id :last_modify_time [:e_shop.name :title] [:e_shop.shop_img :img])
          (join shops (= :e_shop.uuid :shop_id))
          (where {:user_id user-id}))
  )
