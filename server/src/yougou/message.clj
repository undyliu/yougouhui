(ns yougou.message
  (:use
		[korma.core]
		[yougou.db]
		)
)
(defn save-message [sender receiver content]
  (let [uuid (str (java.util.UUID/randomUUID))
			  current-time (str (System/currentTimeMillis))]

    (insert messages (values {:uuid uuid :sender sender :receiver receiver :content content
                              :send_time current-time :status "0"}))
    {:uuid uuid :send_time current-time}
   )
)
