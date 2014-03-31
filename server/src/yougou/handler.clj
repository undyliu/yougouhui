(ns yougou.handler
  (:use [compojure.core]
	[yougou.activity]
	[yougou.module]
	[yougou.auth]
	[yougou.share]
	[yougou.user]
	)
  (:require [compojure.handler :as handler]
            [compojure.route :as route]
	     [clojure.data.json :as json]
			 [clojure.java.io :as io]
			 [ring.util.response :as response]
			 (ring.middleware [multipart-params :as mp])
			 [yougou.file :as file]
	))

(defroutes default-routes
  (GET "/hello" [] "你好.")
  (route/resources "/")
  (route/not-found "Not Found"))

(defroutes login-routes
	(POST "/login" {{phone :phone, pwd :pwd} :params} (json/write-str (login phone pwd)))
)

(defroutes channel-routes
	(GET "/getActiveChannels" [] (json/write-str (get-channels nil)))
  (GET "/getActiveChannels/:channel-id" [channel-id] (json/write-str (get-channels channel-id)))
)

(defroutes activity-routes
	(GET "/getActivities/:channel-id" [channel-id] (json/write-str (get-activities channel-id)))
	(GET "/getActiveData/:id" [id] (json/write-str (get-activity-data id)))
)

(defroutes module-routes
	(GET "/getModules/:type" [type] (json/write-str (get-modules type)))
)

(defroutes share-routes
	(POST "/getFriendShares" {{last-pub-time :last-pub-time, min-pub-time :min-pub-time, last-comm-pub-time :last-comm-pub-time min-comm-pub-time :min-comm-pub-time} :params} 
		(json/write-str (get-friend-share-data last-pub-time min-pub-time last-comm-pub-time min-comm-pub-time)))
	(POST "/saveShare" {params :params}
		;(println params)
		(try
			(json/write-str (save-share params))
			(catch Exception e {:status  500 :body (json/write-str{:error "保存失败."})})
		)
	)
	(POST "/saveComment" {{share-id :share_id content :content, user :publisher} :params} 
		(try
			(json/write-str (save-comment share-id content user))
			(catch Exception e {:status  500 :body (json/write-str{:error "保存失败."})})
		)	
	)
	(DELETE "/deleteShare/:share-id" [share-id] 
		(try
			(json/write-str (del-share-data share-id))
			(catch Exception e {:status  500 :body (json/write-str{:error "删除失败."})})
		)
	)
	(DELETE "/deleteComment/:comment-id" [comment-id]
		(try
			(json/write-str (del-comment comment-id))
			(catch Exception e {:status  500 :body (json/write-str{:error "删除失败."})})
		)
	)
)

(defroutes file-routes
	(GET "/getImageFile/:file-name" [file-name] (file/get-image-file file-name))
)

(defroutes user-routes
	(POST "/registerUser" {{name :name phone :phone pwd :pwd photo :photo :as params} :params}
	  ;(println params)
		(try
			(if photo
				(json/write-str (register-user (java.net.URLDecoder/decode name "utf-8") phone pwd photo (:tempfile (params photo))))
				(json/write-str (register-user (java.net.URLDecoder/decode name "utf-8") phone pwd photo nil))
			)
			(catch Exception e {:status  500 :body (json/write-str {:error "保存失败."})})
		)
	)
	(PUT "/updateUserName" {{uuid :uuid name :name} :params}
		(try
			(json/write-str (update-user-name uuid (java.net.URLDecoder/decode name "utf-8")))
			(catch Exception e {:status  500 :body (json/write-str {:error "修改失败."})})
		)
	)
	(PUT "/updateUserPwd" {{uuid :uuid pwd :pwd} :params}
		(try
			(json/write-str (update-user-pwd uuid pwd))
			(catch Exception e {:status  500 :body (json/write-str {:error "修改失败."})})
		)
	)
	(POST "/saveUserPhoto" {{uuid :uuid photo :photo :as params} :params}
		(try
			(if photo
				(json/write-str (save-user-photo uuid photo (:tempfile (params photo))))
				(json/write-str (save-user-photo uuid photo nil))
			)
			(catch Exception e {:status  500 :body (json/write-str {:error "保存头像失败."})})
		)
	)
)

(def app
  (-> (routes login-routes channel-routes activity-routes module-routes share-routes file-routes user-routes default-routes)
      (handler/site :session)
      ))