(ns yougou.handler
  (:use [compojure.core]
	[yougou.activity]
	[yougou.module]
	[yougou.auth]
	)
  (:require [compojure.handler :as handler]
            [compojure.route :as route]
	     [clojure.data.json :as json]
	))

(defroutes app-routes
  (GET "/hello" [] "你好.")
  (GET "/getActiveChannels" [] (json/write-str (get-channels nil)))
  (GET "/getActiveChannels/:channel-id" [channel-id] (json/write-str (get-channels channel-id)))
  (GET "/getActivities/:channel-id" [channel-id] (json/write-str (get-activities channel-id)))
  (GET "/getModules/:type" [type] (json/write-str (get-modules type)))
  (GET "/getFriendGroupInfo/:user-id" [user-id] (json/write-str "[]"))
  (GET "/getNearbyDiscounts/:user-id" [user-id] (json/write-str "[]"))
  (GET "/getNearbyShops/:user-id" [user-id] (json/write-str "[]"))
  (GET "/getActiveData/:id" [id] (json/write-str (get-activity-data id)))
  (GET "/getContactList/:user-id" [user-id] (json/write-str "[]"))
  (GET "/getFavoriteList/:user-id" [user-id] (json/write-str "[]"))
  (GET "/getShareList/:user-id" [user-id] (json/write-str "[]"))
  (POST "/login" {{phone :phone, pwd :pwd} :params} (json/write-str (login phone pwd)))
  (route/resources "/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
