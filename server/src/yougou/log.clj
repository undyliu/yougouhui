(ns yougou.log
  (:use
		[korma.core]
		[yougou.db]
		)
)

(defn log-request [handler]
  (fn [request]
    (let [action  (str (:request-method request))
          val-map {:uuid (str (java.util.UUID/randomUUID))
                    :act_time (System/currentTimeMillis)
                    :remote_addr (:remote-addr request)
                    :action action
                    :act_uri (:uri request)
                    }
          ]
      (println action)
      (if (or (= action ":put") (= action ":post"))
        (insert logs (values (assoc val-map :act_content (:params request))))
        (insert logs (values (assoc val-map :act_content (:query-string request))))
        )

        (handler request)
      )
   )
  )
