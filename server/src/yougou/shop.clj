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

(declare create-shop-barcode)

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
                       (fields :uuid :name :location :address :desc :shop_img :busi_license :register_time :owner :status :barcode)
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
            current-time (str (System/currentTimeMillis))
            ]
        (if trade-id
          (insert shop-trades (values {:uuid uuid :shop_id shop-id :trade_id trade-id :last_modify_time current-time}))
        )
        (recur (rest trade-list) (conj result {:uuid uuid :trade_id trade-id}))
        )
      )
	)
)

(defn save-shop-emp [shop-id user-id pwd]
  (let [uuid (str (java.util.UUID/randomUUID))
        current-time (str  (System/currentTimeMillis))
        ]
    (insert shop-emps (values {:uuid uuid :shop_id shop-id :user_id user-id :pwd pwd :last_modify_time current-time}))
    {:uuid uuid}
    )
  )

(defn save-shop [name desc location address shop-img busi-license owner files]
	(let [uuid (str (java.util.UUID/randomUUID))
        current-time (str  (System/currentTimeMillis))
        val-map {:uuid uuid :name name :desc desc :location location :address address :shop_img shop-img
               :busi_license busi-license :register_time current-time :owner owner :last_modify_time current-time}
        ]
    (if location
      (insert shops (values (assoc val-map :latitude (:latitude location) :longitude (:longitude location))))
      (insert shops (values val-map))
      )

    (file/save-image-file shop-img (files shop-img))
    (file/save-image-file busi-license (files busi-license))
    {:uuid uuid :register_time current-time :status 0}
   )
)

(defn save-shop-data [name desc location address shop-img busi-license owner pwd files trades]
  (let [shop (save-shop name desc location address shop-img busi-license owner files)
        shop-id (:uuid shop)
        trade-list (save-shop-trades shop-id trades)
        emp-list (save-shop-emp shop-id owner pwd)
        ]
    (assoc (merge shop (create-shop-barcode shop-id)) :tradeList trade-list :empList emp-list)
   )
  )

(defn login-shop [user-id pwd]
  (let [shop-list (select shops (fields :uuid :name :location :address :desc :shop_img :busi_license :register_time :owner :status :barcode)
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
      {:authed true :data shop-list :update_time (str  (System/currentTimeMillis))}
      )
    )
  )

(defn update-shop [field-name value shop-id temp-file]
  (let [current-time (str (System/currentTimeMillis))]
  (cond
   (= field-name "shop_img")
     (let [old-images (select shops (fields :shop_img) (where {:uuid shop-id}))]
        (update shops (set-fields {:shop_img value :last_modify_time current-time}) (where {:uuid shop-id}))
        (file/del-image-files old-images)
        (file/save-image-file value temp-file)
      )
   (= field-name "busi_license")
     (let [old-images (select shops (fields :busi_license) (where {:uuid shop-id}))]
        (update shops (set-fields {:busi_license value :last_modify_time current-time}) (where {:uuid shop-id}))
        (file/del-image-files old-images)
        (file/save-image-file value temp-file)
      )
   (= field-name "desc") (update shops (set-fields {:desc value :last_modify_time current-time}) (where {:uuid shop-id}))
   :else (update shops (set-fields {(str field-name) value :last_modify_time current-time}) (where {:uuid shop-id}))
   )
  {:uuid shop-id}
    )
 )

(defn validate-shop-emp-pwd [shop-id user-id pwd]
  (let [pwd-db (:pwd (first (select shop-emps (fields :pwd) (where {:shop_id shop-id :user_id user-id}))))]
    (if (= pwd pwd-db) true false)
    )
   )
(defn set-shop-emp-pwd [shop-id user-id new-pwd]
  {:rows (update shop-emps (set-fields {:pwd new-pwd :last_modify_time (str (System/currentTimeMillis))})
                 (where {:shop_id shop-id :user_id user-id}))}
 )

(defn update-shop-emp-pwd [shop-id user-id old-pwd new-pwd]
  (if (validate-shop-emp-pwd shop-id user-id old-pwd)
    (set-shop-emp-pwd shop-id user-id new-pwd)
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
        (let [old-barcode (:barcode shop)
              current-time (str  (System/currentTimeMillis))
              ]
         (if old-barcode
           (file/del-image-files (list old-barcode))
           )
         (update shops (set-fields {:barcode barcode :last_modify_time current-time}) (where {:uuid shop-id}))
         {:barcode barcode})
        {:barcode ""}
       )
    )
  )
(defn get-shop-emps [shop-id]
  (select users (fields :uuid :name :photo [:e_shop_emp.pwd :pwd])
          (join shop-emps (= :e_shop_emp.user_id :uuid))
          (where {:e_shop_emp.shop_id shop-id}))
  )
(defn save-shop-emps [shop-id emp-list del-flag]
  (if emp-list
    (loop [emps emp-list]
      (if (> (count emps) 0)
        (let [emp-id (first emps)
              uuid (str (java.util.UUID/randomUUID))
              current-time (str  (System/currentTimeMillis))
              ]
          (if emp-id
            (if del-flag
              (delete shop-emps (where {:shop_id shop-id :user_id emp-id}))
              (insert shop-emps (values {:uuid uuid :shop_id shop-id :user_id emp-id :last_modify_time current-time}))
              )
            )
          (recur (rest emps))
         )
       )
     )
   )
  {:uuid shop-id}
  )

(defn search-shop [word]
  (let [search-word (str "%" word "%")]
   (select shops (fields :uuid :name :shop_img :barcode :owner)
           (where {:name [like search-word] :status "1"}))
   )
  )

(defn get-shops-by-distance [lat lon dist offset-val]
  (exec
     (-> (select* shops)
        (fields :uuid :name :shop_img :barcode :owner
                [(sqlfn geodist_field lat lon :latitude :longitude) :distance]
                 )
         (where {:status "1"})
         (where (and (< :latitude (+ lat 1)) (> :latitude (- lat 1)) (< :longitude (+ lon 1)) (> :longitude (- lon 1))))
         ;(where (and (and (< :latitude (+ lat 1)) (> :latitude (- lat 1))) (and (< :longitude (+ lon 1)) (> :longitude (- lon 1)))))
         ;(where (and (and (and (and (< :latitude (+ lat 1))) (> :latitude (- lat 1))) (< :longitude (+ lon 1))) (> :longitude (- lon 1))))
         (having {:distance [<= dist]})
         (order :distance)
         (limit def-page-size)
         (offset offset-val)
      )
     )
  )

(defn check-shop-emp [shop-id emp-id]
  (if-let [shop-emp (first (select shop-emps (fields :uuid) (where {:shop_id shop-id :user_id emp-id})))]
    shop-emp
    {}
   )
  )
