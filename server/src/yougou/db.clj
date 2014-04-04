(ns yougou.db
  (:use [korma.db]
        [korma.core]))

(defdb db-mysql (mysql {:host "127.0.0.1" :port 3306 :db "ebs" :user "ebs" :password "1"}))

(declare activities-img activities discusses channels shares share-images comments)

(defentity activities-img
  (table :e_activity_img)
  (pk :uuid)
  (belongs-to activities {:fk :activity_id})
)

(defentity activities
  (table :e_activity)
  (pk :uuid)
  (has-many activities-img)
  (has-many discusses)
  (belongs-to channels {:fk :channel_id})
)

(defentity discusses
  (table :e_discuss)
  (pk :uuid)
  (belongs-to activities {:fk :activity_id})
)

(defentity channels
  (table :e_channel)
  (pk :uuid)
  (has-many activities)
)

(defentity modules
  (table :e_module)
  (pk :uuid)
)

(defentity users
  (table :e_user)
  (pk :uuid)
)

(defentity friends
  (table :e_friend)
  (pk :uuid)
)

(defentity shares
  (table :e_share)
	(has-many share-images)
	(has-many comments)
  (pk :uuid)
)

(defentity share-images
  (table :e_share_img)
  (pk :uuid)
  (belongs-to shares {:fk :share_id})
)

(defentity comments
  (table :e_comment)
  (pk :uuid)
  (belongs-to shares {:fk :share_id})
)

(defentity trades
  (table :e_trade)
  (pk :uuid)
)