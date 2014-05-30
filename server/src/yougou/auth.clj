(ns yougou.auth
  (:use [yougou.db]
        [korma.core])
  (:require [ring.util.response :as resp]
            [pandect.core :as pandect]
            [clojure.data.json :as json]
  ))

(defn- get-user [phone]
  (if-let [user (first (select users (fields :uuid :name :pwd :type :phone :photo :register_time) (where {:phone phone})))] user {} ))

(defn- logged-in? [request]
  (get-in request [:session :user] false))

(defn authenticated? [handler]
  (fn [request]
    ;(println request)
    (let [uri (:uri request)]
      (if (or (logged-in? request) (= (:request-method request) :get));;(.endsWith uri ".png") (.startsWith uri "/app")
        (handler request)
        {:status 200 :body (json/write-str{:error "请先登录."})}
      )
      )
    )
  )

(defn- encrypt [password] (pandect/md5 password))

(defn- password-is-valid? [password-login password-in-db]
 ; (= (encrypt password-login) password-in-db)
  (= password-login password-in-db)
  )

(defn login [request]
  ;(println request)
  (let [{{phone :phone, password :pwd} :params} request
        user (get-user phone)
        no-error (and (:uuid user) (password-is-valid? password (:pwd user)))]

     (if no-error
       (let [result {:authed true :user user}]
         ;(println result)
         {
          :status 200
          :session (assoc (request :session) :user user)
          :body (json/write-str result)
          }
        )
       {
        :status 200
         :body (json/write-str {:authed false, :error-type (if (:uuid user) :pass-error :user-error)})
        }
       )

  )
)
