(ns yougou.friend
  (:use
		[korma.core]
		[yougou.db]
	)
	(:require
		[yougou.user :as user]
	)
)

(defn add-friend [user-id friend-id]
	(if-let [friend (first (select friends (fields :uuid) (where {:user_id user-id :friend_id friend-id})))]
    friend
    (let [uuid (str (java.util.UUID/randomUUID))
        currentTime (System/currentTimeMillis)
          ]
      (insert friends (values {:uuid uuid :user_id user-id :friend_id friend-id :last_modify_time currentTime}))
	    {:uuid uuid}
      )
		)
)

(defn del-friend [user-id friend-id]
  (let [del-friends (select friends (fields :uuid) (where {:user_id user-id :friend_id friend-id}))]
    (delete friends (where {:user_id user-id :friend_id friend-id}))
    (first del-friends)
   )
)

(defn del-friend [uuid]
  (delete friends (where {:uuid uuid}))
  {:uuid uuid}
  )

(defn get-friends [user-id]
	(let [user-friends (select friends (fields :uuid :user_id :friend_id) (where {:user_id user-id}))]
		(loop [friend-list user-friends
					result []
					]
			(if (= 0 (count friend-list))
				result
				(let [friend (first friend-list)
							user (user/get-user-without-pwd (:friend_id friend))
						]
					(recur (rest friend-list) (conj result (assoc friend :user user)))
				)
			)
		)
	)
)

