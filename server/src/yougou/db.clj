(ns yougou.db
  (:use [korma.db]
        [korma.core]))

(defdb db-mysql (mysql {:host "127.0.0.1" :port 3306 :db "ebs" :user "ebs" :password "1"}))

(declare sale-images sales sale-discusses channels trades shares share-images share-comments shops shop-trades shop-emps users)

;;base tables
(defentity trades
  (table :e_trade)
  (pk :uuid)
)

(defentity channels
  (table :e_channel)
  (pk :uuid)
)

(defentity channel-trades
  (table :e_mapping_ct)
  (pk :uuid)
  )

(defentity modules
  (table :e_module)
  (pk :uuid)
)

;;user tables
(defentity users
  (table :e_user)
  (pk :uuid)
)

(defentity friends
  (table :e_friend)
  (pk :uuid)
)

;;share tables
(defentity shares
  (table :e_share)
	(has-many share-images)
	(has-many share-comments)
  (pk :uuid)
)

(defentity share-images
  (table :e_share_img)
  (pk :uuid)
  (belongs-to shares {:fk :share_id})
)

(defentity share-comments
  (table :e_share_comment)
  (pk :uuid)
  (belongs-to shares {:fk :share_id})
)

;;shop tables
(defentity shop-trades
  (table :e_shop_trade)
  (pk :uuid)
  (belongs-to shops {:fk :shop_id})
  )

(defentity shop-emps
  (table :e_shop_emp)
  (pk :uuid)
  (belongs-to shops {:fk :shop_id})
  (belongs-to users {:fk :user_id})
  )

(defentity shops
  (table :e_shop)
  (pk :uuid)
  )
(defentity shop-favorites
  (table :e_shop_favorit)
  (pk :uuid)
  )

;;sale tables
(defentity sale-images
  (table :e_sale_img)
  (pk :uuid)
  (belongs-to sales {:fk :sale_id})
)

(defentity sales
  (table :e_sale)
  (pk :uuid)
  (has-many sale-images)
  (has-many sale-discusses)
  (belongs-to shops {:fk :shop_id})
  (belongs-to trades {:fk :trade_id})
)

(defentity sale-discusses
  (table :e_sale_discuss)
  (pk :uuid)
  (belongs-to sales {:fk :sale_id})
)

(defentity sale-visites
  (table :e_sale_visit)
  (pk :uuid)
  )

(defentity sale-favorites
  (table :e_sale_favorit)
  (pk :uuid)
  )

(defentity settings
  (table :e_setting)
  (pk :uuid)
  )
