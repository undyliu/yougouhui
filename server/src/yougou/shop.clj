(ns yougou.shop
  (:use
		[korma.core]
		[yougou.db]
	)
  (:require
		[yougou.file :as file]
    [yougou.qrcode :as qrcode]
	)
)

(defn get-trades []
  (exec (-> (select* trades )
            (fields :uuid :code :name)
            (where {:is_used [= 1]})
            (order :ord_index)
            )
        )
)

(defn get-shop [shop-id]
	(let [shop (first (select shops
                       (fields :uuid :name :address :desc :shop_img :busi_license :register_time :owner :status :barcode)
                       (where {:uuid shop-id})
                     )
                    )
        trade-list (select shop-trades (fields :uuid :trade_id) (where {:shop_id shop-id}))

        ]
   (assoc shop :tradeList trade-list)
    )
)

(defn save-shop-trades [shop-id trades]
  (loop [trade-list trades result []]
    (if (= (count trade-list) 0)
      result
      (let [uuid (str (java.util.UUID/randomUUID))
            trade-id (first trade-list)
            ]
        (if trade-id
          (insert shop-trades (values {:uuid uuid :shop_id shop-id :trade_id trade-id}))
        )
        (recur (rest trade-list) (conj result {:uuid uuid :trade_id trade-id}))
        )
      )
	)
)

(defn save-shop-emps [shop-id user-id pwd]
  (let [uuid (str (java.util.UUID/randomUUID))
        ]
    (insert shop-emps (values {:uuid uuid :shop_id shop-id :user_id user-id :pwd pwd}))
    {:uuid uuid}
    )
  )

(defn save-shop [name desc address shop-img busi-license owner files]
	(let [uuid (str (java.util.UUID/randomUUID))
        register-time (str  (System/currentTimeMillis))
        ]
    (insert shops
      (values {:uuid uuid :name name :desc desc :address address :shop_img shop-img :busi_license busi-license :register_time register-time :owner owner})
    )
    (file/save-image-file shop-img (files shop-img))
    (file/save-image-file busi-license (files busi-license))
    {:uuid uuid :register_time register-time}
   )
)

(defn save-shop-data [name desc address shop-img busi-license owner pwd files trades]
  (let [shop (save-shop name desc address shop-img busi-license owner files)
        shop-id (:uuid shop)
        trade-list (save-shop-trades shop-id trades)
        emp-list (save-shop-emps shop-id owner pwd)
        ]
    (assoc (assoc shop :tradeList trade-list) :empList emp-list)
   )
  )

(defn login-shop [user-id pwd]
  (let [shop-list (select shops (fields :uuid :name :shop_img :owner :status)
                          (join shop-emps (= :e_shop_emp.shop_id :uuid))
                          (where {:e_shop_emp.user_id user-id :e_shop_emp.pwd pwd}))
        ]
    (if (= 0 (count shop-list))
      (let [shop-no-pwd (select shop-emps (fields :shop_id) (where {:user_id user-id}))]
        (if (= 0 (count shop-no-pwd))
          {:authed false :error-type :user-error}
          {:authed false :error-type :pass-error}
          )
       )
      {:authed true :shopList shop-list}
      )
    )
  )

(defn update-shop [field-name value shop-id temp-file]
  (cond
   (= field-name "shop_img")
     (let [old-images (select shops (fields :shop_img) (where {:uuid shop-id}))]
        (update shops (set-fields {:shop_img value}) (where {:uuid shop-id}))
        (file/del-image-files old-images)
        (file/save-image-file value temp-file)
      )
   (= field-name "busi_license")
     (let [old-images (select shops (fields :busi_license) (where {:uuid shop-id}))]
        (update shops (set-fields {:busi_license value}) (where {:uuid shop-id}))
        (file/del-image-files old-images)
        (file/save-image-file value temp-file)
      )
   (= field-name "desc") (update shops (set-fields {:desc value}) (where {:uuid shop-id}))
   :else (update shops (set-fields {(str field-name) value}) (where {:uuid shop-id}))
   )
  {:uuid shop-id}
 )

(defn validate-shop-emp-pwd [shop-id user-id pwd]
  (let [pwd-db (:pwd (first (select shop-emps (fields :pwd) (where {:shop_id shop-id :user_id user-id}))))]
    (if (= pwd pwd-db) true false)
    )
   )

(defn update-shop-emp-pwd [shop-id user-id old-pwd new-pwd]
  (if (validate-shop-emp-pwd shop-id user-id old-pwd)
    {:rows (update shop-emps (set-fields {:pwd new-pwd}) (where {:shop_id shop-id :user_id user-id}))}
    {:error-type :old-pass-incorrect}
    )
  )

(defn update-shop-trades [shop-id trades]
  (delete shop-trades (where {:shop_id shop-id}))
  {:tradeList (save-shop-trades shop-id trades)}
  )

(defn create-shop-barcode [shop-id]
  (let [shop (first (select shops (fields :shop_img :name :barcode) (where {:uuid shop-id})))
        content (str shop-id "##" (:name shop))
        logo-path (.getPath (file/get-image-file (:shop_img shop)))
        barcode  (str "barcode_" (.hashCode shop-id) "_" (System/currentTimeMillis) ".png")
        image-path (.getPath (file/get-image-file barcode))
        width 300
        ]
      (if (qrcode/encode-qrcode-image content image-path width width logo-path)
        (let [old-barcode (:barcode shop)]
         (if old-barcode
           (file/del-image-files (list old-barcode))
           )
         (update shops (set-fields {:barcode barcode}) (where {:uuid shop-id}))
         {:barcode barcode})
        {:barcode ""}
       )
    )
  )
