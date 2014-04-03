(ns yougou.friend
  (:use 
		[korma.core]
		[yougou.db]
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