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
	(let [uuid (str (java.util.UUID/randomUUID))]
		(insert friends (values {:uuid uuid :user_id user-id :friend_id friend-id}))
	{:uuid uuid})
)

(defn del-friend [user-id friend-id]
	(update friends (set-fields {:is_deleted 1}) (where {:user_id user-id :friend_id friend-id}))
	(first (select friends (fields :uuid) (where {:user_id user-id :friend_id friend-id})))
)

(defn get-friends [user-id]
	(let [user-friends (select friends (fields :uuid :user_id :friend_id) (where {:user_id user-id :is_deleted [not= 1]}))]
		(loop [friend-list user-friends
					result []
					]
			(if (= 0 (count friend-list))
				result
				(let [friend (first friend-list)
							user (user/get-user-by-id (:friend_id friend))
						]
					(recur (rest friend-list) (conj result (assoc friend :user user)))
				)
			)
		)
	)
)
