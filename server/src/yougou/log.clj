(ns yougou.log
  (:use
		[korma.core]
		[yougou.db]
    [yougou.date]
    [clojure.tools.logging]
		)
  (:require [clojure.data.json :as json])
)

(defn log-request [handler]
  (fn [request]
    (try
      (let [action  (str (:request-method request))
            current-time (System/currentTimeMillis)
            val-map {:uuid (str (java.util.UUID/randomUUID))
                      :act_time (formatTime current-time)
                      :last_modify_time current-time
                      :remote_addr (:remote-addr request)
                      :action action
                      :act_uri (:uri request)
                      :act_content (if (or (= action ":put") (= action ":post")) (str (dissoc (:params request) :pwd)) nil)
                      :user_id (if-let [user (:user (:session request))] (:uuid user) nil)
                      :user_phone ((:headers request) "phone")
                    }
            ]
          ;(println ((:headers request) "phone"))
          ;(println request)
          (insert logs (values val-map))
          (handler request)
        )
        (catch Exception e
          (error e (str  "远程访问失败.请求信息：" request))
          {:status  200 :body (json/write-str {:error "远程访问失败."})}
          )
      )
   )
  )
