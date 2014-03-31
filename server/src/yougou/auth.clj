(ns yougou.auth
  (:use [yougou.db]
        [korma.core])
  (:require [ring.util.response :as resp]
            [pandect.core :as pandect]
  ))

(defn get-user [phone]
  (if-let [user (first (select users (fields :uuid :name :pwd :phone :photo) (where {:phone phone})))] user {} ))

(defn logged-in? [req]
  (get-in req [:session :user] false))

(defn encrypt [password] (pandect/md5 password))

(defn password-is-valid? [password-login password-in-db]
 ; (= (encrypt password-login) password-in-db)
  true
  )

(defn login [phone password]
  (let [user (get-user phone)
        no-error (and (:uuid user) (password-is-valid? password (:pwd user)))]
    ;(println phone)
    (if no-error
      {:authed true :user user}
      {:authed false, :error-type (if (:id user) :pass-error :user-error)}
    )
  )
)
