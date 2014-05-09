(ns yougou.handler
  (:use [compojure.core]
	      [yougou.sale]
	      [yougou.module]
	      [yougou.auth]
	      [yougou.share]
	      [yougou.user]
	      [yougou.friend]
	      [yougou.shop]
        [yougou.favorit]
        [yougou.setting]
        [yougou.log]
        )
  (:require [compojure.handler :as handler]
            [compojure.route :as route]
	          [clojure.data.json :as json]
			      [clojure.java.io :as io]
			      [ring.util.response :as response]
			      (ring.middleware [multipart-params :as mp])
			      [yougou.file :as file]
            [ring.middleware.cookies]
	))

;;对返回结果包装最后更新时间的信息
(defn wrapper-update-data [result update-time]
  (json/write-str (assoc {} :data result :update_time update-time))
  )

(defroutes channel-routes
	(GET "/getChannels" [] (json/write-str (get-channels nil)))
  (GET "/getChannels/:parent-id" [parent-id] (json/write-str (get-channels parent-id)))
)

(defroutes sale-routes
	(GET "/getSalesByChannel/:channel-id/:update-time" [channel-id update-time]
       (let [current-time (str (System/currentTimeMillis)) ]
         (wrapper-update-data (get-sales-by-channel channel-id update-time) current-time)
         )
       )
  (GET "/getSalesByShop/:shop-id/:update-time" [shop-id update-time]
       (let [current-time (str (System/currentTimeMillis)) ]
         (wrapper-update-data (get-sales-by-shop shop-id update-time) current-time)
         )
	    )
  (GET "/getSaleData/:id/:user-id" [id user-id] (json/write-str (get-sale-data id user-id)))
  (POST "/addSale" {{title :title content :content start-date :start_date end-date :end_date shop-id :shop_id trade-id :trade_id publisher :publisher :as params} :params}
        ;(println params)
        (let [image-names (clojure.string/split (java.net.URLDecoder/decode (:fileNameList params) "utf-8") #"[|]")
              title (java.net.URLDecoder/decode title "utf-8")
              content (java.net.URLDecoder/decode content "utf-8")
              ]
          (json/write-str (save-sale-data title content start-date end-date shop-id trade-id publisher image-names params))
          )
        )
  (POST "/addSaleDiscuss" {{sale-id :sale_id user-id :publisher content :content} :params}
			(json/write-str (save-sale-discuss sale-id user-id content))
	)
  (DELETE "/deleteSaleDiscuss/:uuid" [uuid]
			(json/write-str (del-sale-discuss uuid))
	)
  (GET "/getSaleDiscusses/:sale-id/:update-time" [sale-id update-time]
       (let [current-time (str (System/currentTimeMillis)) ]
         (wrapper-update-data (get-sale-discusses sale-id update-time) current-time)
         )
       )

  (PUT "/cancelSale" {{sale-id :sale_id} :params}
			(json/write-str (cancel-sale sale-id))
	)
  (GET "/getSalesByDistance/:lat/:lon/:distance/:offset" [lat lon distance offset]
       (json/write-str (get-sales-by-distance (Double/valueOf lat) (Double/valueOf lon) distance offset))
     )
)

(defroutes module-routes
	(GET "/getModules/:type" [type] (json/write-str (get-modules type)))
)

(defroutes share-routes
	(GET "/getFriendShares/:user-id/:update-time" [user-id update-time]
		(let [current-time (str (System/currentTimeMillis)) ]
     (wrapper-update-data (get-friend-share-data update-time user-id) current-time)
      )
   )
  (GET "/getShopShares/:shop-id/:update-time" [shop-id update-time]
		(let [current-time (str (System/currentTimeMillis)) ]
     (wrapper-update-data (get-shop-share-data shop-id update-time) current-time)
      )
   )

	(POST "/saveShare" {params :params}
			(json/write-str (save-share params))
	)
  (POST "/saveShareReply" {{share-id :share_id shop-id :shop_id content :content grade :grade replier :replier} :params}
			(json/write-str (save-share-shop-reply share-id shop-id content grade replier))
	)
	(POST "/saveComment" {{share-id :share_id content :content, user :publisher} :params}
			(json/write-str (save-comment share-id content user))
	)
	(DELETE "/deleteShare/:share-id" [share-id]
			(json/write-str (del-share-data share-id))
	)
	(DELETE "/deleteComment/:comment-id" [comment-id]
			(json/write-str (del-comment comment-id))
	)
  (GET "/getUserShares/:user-id" [user-id] (json/write-str (get-user-share-data user-id)))
)

(defroutes file-routes
	(GET "/getImageFile/:file-name" [file-name] (file/get-image-file file-name))
)

(defroutes user-routes
	(PUT "/updateUserName" {{uuid :uuid name :name} :params}
			(json/write-str (update-user-name uuid (java.net.URLDecoder/decode name "utf-8")))
	)
	(PUT "/updateUserPwd" {{uuid :uuid pwd :pwd} :params}
			(json/write-str (update-user-pwd uuid pwd))
	)
	(POST "/saveUserPhoto" {{uuid :uuid photo :photo :as params} :params}
			(if photo
				(json/write-str (save-user-photo uuid photo (:tempfile (params photo))))
				(json/write-str (save-user-photo uuid photo nil))
			)
	)
	(POST "/searchUsers" {{word :search-word} :params} (json/write-str (search-user-exact (java.net.URLDecoder/decode word "utf-8"))))
  (GET "/getUserProfile/:user-id" [user-id] (json/write-str (get-user-profile user-id)))
  (GET "/getUserTotalGrade/:user-id" [user-id] (json/write-str (get-user-total-grade user-id)))
  (GET "/getUserGradeItems/:user-id" [user-id] (json/write-str (get-user-grade-items user-id)))
)

(defroutes friend-routes
	(POST "/addFriend" {{user-id :user_id friend-id :friend_id} :params}
			(json/write-str (add-friend user-id friend-id))
	)
	(DELETE "/deleteFriend/:user-id/:friend-id" [user-id friend-id]
			(json/write-str (del-friend user-id friend-id))
	)
	(GET "/getFriends/:user-id" [user-id] (json/write-str (get-friends user-id))
	)
)

(defroutes shop-routes
	(GET "/getTrades" [] (json/write-str (get-trades)))
  (POST "/registerShop" {{name :name location :location address :address desc :desc shop-img :shop_img
                          busi-license :busi_license owner :owner pwd :pwd :as params} :params}
    (let [files {shop-img (:tempfile (params shop-img)) busi-license (:tempfile (params busi-license))}
          trades (clojure.string/split (java.net.URLDecoder/decode (:tradeList params) "utf-8") #"[|]")
          ]
        (json/write-str (save-shop-data (java.net.URLDecoder/decode name "utf-8") (java.net.URLDecoder/decode desc "utf-8")
                                        (java.net.URLDecoder/decode location "utf-8") (java.net.URLDecoder/decode address "utf-8")
                                        shop-img busi-license owner pwd files trades))
    )
  )
  (POST "/loginShop" {{user-id :user_id, pwd :pwd} :params}
       (json/write-str (login-shop user-id pwd))
   )
  (GET "/getShop/:shop-id" [shop-id] (json/write-str (get-shop shop-id)))
  (POST "/updateShop" {{shop-id :shop_id field-name :field value :value :as params} :params}
     (let [file (:tempfile (params value))]
         (json/write-str (update-shop field-name (java.net.URLDecoder/decode value "utf-8") shop-id file))
      )
   )
  (PUT "/updateShopEmpPwd" {{shop-id :shop_id user-id :user_id old-pwd :old_pwd new-pwd :pwd} :params}
       (json/write-str (update-shop-emp-pwd shop-id user-id old-pwd new-pwd))
   )
  (PUT "/updateShopTrades" {{shop-id :shop_id trade-list :tradeList} :params}
       (let [trades (clojure.string/split (java.net.URLDecoder/decode trade-list "utf-8") #"[|]")]
           (json/write-str (update-shop-trades shop-id trades))
        )
       )
  (POST "/createShopBarcode" {{shop-id :shop_id} :params}
       (json/write-str (create-shop-barcode shop-id))
   )
  (GET "/getShopEmps/:shop-id" [shop-id] (json/write-str (get-shop-emps shop-id)))
  (POST "/addShopEmps" {{shop-id :shop_id emps :emps} :params}
    (json/write-str (save-shop-emps shop-id (clojure.string/split (java.net.URLDecoder/decode emps "utf-8") #"[|]") false))
   )
  (DELETE "/deleteShopEmps/:shop-id/:emps" [shop-id emps]
    (json/write-str (save-shop-emps shop-id (clojure.string/split (java.net.URLDecoder/decode emps "utf-8") #"[|]") true))
   )
  (PUT "/setShopEmpPwd" {{shop-id :shop_id user-id :user_id new-pwd :pwd} :params}
    (json/write-str (set-shop-emp-pwd shop-id user-id  new-pwd))
   )
  (POST "/searchShops" {{word :search-word} :params}
        (json/write-str (search-shop (java.net.URLDecoder/decode word "utf-8"))))
  (GET "/getShopsByDistance/:lat/:lon/:distance/:offset" [lat lon distance offset]
     (json/write-str (get-shops-by-distance (Double/valueOf lat) (Double/valueOf lon) distance offset))
    )
  (GET "/checkShopEmp/:shop-id/:emp-id" [shop-id emp-id]
     (json/write-str (check-shop-emp shop-id emp-id))
   )
)

(defroutes favorit-routes
 (POST "/addSaleFavorit" {{sale-id :sale_id user-id :user_id} :params}
		(json/write-str (save-sale-favorit user-id sale-id))
	)
 (POST "/addShopFavorit" {{shop-id :shop_id user-id :user_id} :params}
		(json/write-str (save-shop-favorit user-id shop-id))
	)
  (GET "/getSaleFavoritesByUser/:user-id" [user-id]
     (json/write-str (get-sale-favorites-by-user user-id))
   )
  (GET "/getShopFavoritesByUser/:user-id" [user-id]
     (json/write-str (get-shop-favorites-by-user user-id))
   )
  (DELETE "/deleteSaleFavorit/:user-id/:sale-id" [user-id sale-id]
		(json/write-str (del-sale-favorit user-id sale-id))
	)
  (DELETE "/deleteShopFavorit/:user-id/:shop-id" [user-id shop-id]
		(json/write-str (del-shop-favorit user-id shop-id))
	)
 )

(defroutes setting-routes
	(GET "/getSettings" [] (json/write-str (get-settings)))
)

(def app-routes
  (routes channel-routes sale-routes module-routes share-routes file-routes user-routes friend-routes shop-routes favorit-routes setting-routes)
  )

(defroutes login-routes
	(POST "/login" request (login request))
  (POST "/registerUser" {{name :name phone :phone pwd :pwd photo :photo type :type :as params} :params}
			(if photo
				(json/write-str (register-user (java.net.URLDecoder/decode name "utf-8") phone pwd type photo (:tempfile (params photo))))
				(json/write-str (register-user (java.net.URLDecoder/decode name "utf-8") phone pwd type photo nil))
			)
	)
)

(defroutes auth-routes
  ;(GET "/index.html" request)
  ;(GET "/aa" request (get (json/read-str (:location (get-shop "b7d34ff0-21db-44df-8626-04231feb078e"))) "latitude"))
  (authenticated? app-routes)
  (route/resources "/")
  (route/not-found "Not Found")
)

(def app
  (-> (routes login-routes auth-routes)
      (log-request)
      (handler/site :session)
      (ring.middleware.cookies/wrap-cookies)
      ))
