(ns yougou.auth
  (:use [yougou.db]
        [korma.core])
  (:require [ring.util.response :as resp]
            [pandect.core :as pandect]
            [net.cgrand.enlive-html :as html]))

(def login-path "/login")

(defn get-user [user-id]
  (if-let [user (first (select users (where {:id user-id})))] user {} ))

(defn logged-in? [req]
  "检查是否已经登录，如果没有登录，则重定向到登录页面"
  (get-in req [:session :user] false))

(defn encrypt [password] (pandect/md5 password))

(defn password-is-valid? [password-login password-in-db]
 ; (= (encrypt password-login) password-in-db)
  true
  )

(defn authenticated? [handler]
  "对于需登录才能访问的资源，检查是否已经登录，若未登录则重定向到登录页面"
  (fn [req]
    (let [uri (:uri req)]
      (if (or (logged-in? req)
              (.startsWith uri "/css")
              (.startsWith uri "/js")
              (.startsWith uri "/jslib")
              (.startsWith uri "/images")
              )
        (handler req)
        (resp/redirect login-path)))))

(defn login [user-id password]
  (let [user (get-user user-id)
        no-error (and (:id user) (password-is-valid? password (:mima user)))]
    (if no-error
      (assoc-in (resp/redirect "/home") [:session :user] user)
      (assoc (resp/redirect login-path) :flash
             {:error-type (if (:id user) :pass-error :user-error) :user-id user-id :password password}))))

(html/deftemplate index "public/index.html"
  [{:keys [error-type user-id password]}]
  [:#userid] (if user-id (html/set-attr :value user-id) identity)
  [:#passid] (if user-id (html/set-attr :value password) identity)
  [:#user-error] (if (= error-type :user-error) (html/remove-class "visi") identity)
  [:#pass-error] (if (= error-type :pass-error) (html/remove-class "visi") identity))

(defn login-page [req]
  (resp/content-type (resp/response (index (:flash req))) "text/html;charset=UTF-8" ))