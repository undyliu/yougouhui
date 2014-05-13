(ns yougou.message
  (:use
		[korma.core]
		[yougou.db]
		)
  (:require
		[yougou.shop :as shop]
    [yougou.user :as user]
	)
)
(defn save-message [sender send-shop receiver content]
  (let [uuid (str (java.util.UUID/randomUUID))
			  current-time (str (System/currentTimeMillis))]

    (insert messages (values {:uuid uuid :sender sender :receiver receiver :content content
                              :send_shop send-shop :send_time current-time :status "0"}))
    {:uuid uuid :send_time current-time}
   )
)

(defn get-user-messages [user-id update-time]
  (let [mess (select messages (where {:receiver user-id :send_time [>= update-time]}))]
    (loop [mess-list mess result []]
      (if (= (count mess-list) 0)
        result
        (let [message (assoc (first mess-list) :user-sender (user/get-user-without-pwd (:sender (first mess-list))))
              shop-id (:send_shop message)]
          (recur (rest mess-list) (conj result (if shop-id
                                                (assoc message :shop (shop/get-shop shop-id))
                                                message
                                                )))
          )
        )
      )
    )
  )
