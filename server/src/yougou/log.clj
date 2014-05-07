(ns yougou.log
  (:use
		[korma.core]
		[yougou.db]
    [clojure.tools.logging]
		)
  (:require [clojure.data.json :as json]
   )
)

(defn log-request [handler]
  (fn [request]
    (try
      (let [action  (str (:request-method request))
            val-map {:uuid (str (java.util.UUID/randomUUID))
                    :act_time (System/currentTimeMillis)
                    :remote_addr (:remote-addr request)
                    :action action
                    :act_uri (:uri request)
                    }
            ]
        ;(println request)
        (if (or (= action ":put") (= action ":post"))
          (insert logs (values (assoc val-map :act_content (:params request))))
          (insert logs (values (assoc val-map :act_content (:query-string request))))
          )

          (handler request)
        )
        (catch Exception e
          (error e (str  "远程访问失败.请求信息：" request))
          {:status  200 :body (json/write-str {:error "远程访问失败."})}
          )
      )
   )
  )
