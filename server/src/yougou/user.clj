(ns yougou.user
  (:use
		[korma.core]
    [korma.db]
		[yougou.db]
    [yougou.date]
	)
	(:require
		[yougou.file :as file]
	)
)

(defn register-user [name phone pwd type photo temp-file]
  (if-let [user (first (select users (fields :uuid) (where {:phone phone})))]
    {:error "此手机号已注册."}
    (let [uuid (str (java.util.UUID/randomUUID))
			  register-time (str (System/currentTimeMillis))]
      (transaction
		    (insert users (values {:uuid uuid :name name :phone phone :pwd pwd :photo photo :type type :register_time register-time}))
        (insert user-profiles (values {:uuid uuid :user_id uuid}))
       )
		  (if temp-file
			  (file/save-image-file photo temp-file)
		  )
      {:uuid uuid :register_time register-time})
    )
)

(defn update-user-name [uuid name]
	(update users (set-fields {:name name :last_modify_time (str (System/currentTimeMillis))}) (where {:uuid uuid}))
	{:uuid uuid :name name}
)

(defn update-user-pwd [uuid pwd]
	(update users (set-fields {:pwd pwd :last_modify_time (str (System/currentTimeMillis))}) (where {:uuid uuid}))
	{:uuid uuid :pwd pwd}
)

(defn save-user-photo [uuid photo temp-file]
	(let [photos (select users (fields :photo) (where {:uuid uuid}))]
		(update users (set-fields {:photo photo :last_modify_time (str (System/currentTimeMillis))}) (where {:uuid uuid}))
		(file/del-image-files photos)
		(if temp-file
			(file/save-image-file photo temp-file)
		)
	{:uuid uuid :photo photo}
	)
)

(defn search-user-exact [word]
	(let [search-word (str word )]
		(select users (fields :uuid :name :pwd :phone :photo) (where (or {:phone search-word} {:name search-word})) )
	)
)

(defn search-user [word]
	(let [search-word (str "%" word "%")]
		(select users (fields :uuid :phone :name :photo) (where (or {:phone [like search-word]} {:name [like search-word]})))
	)
)
(defn get-user-without-pwd [user-id]
	(if-let [user (first (select users (fields :uuid :name :phone :photo :register_time) (where {:uuid user-id})))]
		user
		{}
	)
)
(defn get-user-profile [user-id]
  (if-let [user (first (select user-profiles (where {:user_id user-id})))]
    user
    {}
    )
  )

(defn inc-user-share-count [user-id]
  (exec-raw [" update e_user_profile set share_count = share_count + 1 where user_id = ?" [user-id]])
  )
(defn des-user-share-count [user-id]
  (exec-raw [" update e_user_profile set share_count = share_count - 1 where user_id = ?" [user-id]])
  )

(defn inc-user-sale-dis-count [user-id]
  (exec-raw [" update e_user_profile set sale_discuss_count = sale_discuss_count + 1 where user_id = ?" [user-id]])
  )
(defn des-user-sale-dis-count [user-id]
  (exec-raw [" update e_user_profile set sale_discuss_count = sale_discuss_count - 1 where user_id = ?" [user-id]])
  )

(defn update-user-grade-amount [user-id grade]
  (let [grade-str (if (>= (Long/valueOf grade) 0) (str " + " grade) (str " - " grade))]
    (exec-raw [(str " update e_user_profile set grade_amount = grade_amount " grade-str " where user_id = ? ") [user-id]])
    )
  )

(defn update-user-grade-used [user-id grade]
  (let [grade-str (if (>= (Long/valueOf grade) 0) (str " + " grade) (str " - " grade))]
    (exec-raw [(str " update e_user_profile set grade_used = grade_used " grade-str " where user_id = ? ") [user-id]])
    )
  )

(def default-grade-term (* 120 24 60 60 1000))
(def default-grade-remind-term (* 30 24 60 60 1000))

;;积分有效期120天[120 * 24 * 60 * 60 * 1000毫秒]
(defn save-user-grade [user-id shop-id share-id grader grade]
  (let [current-time (System/currentTimeMillis)
        uuid (str (java.util.UUID/randomUUID))]
    (insert user-grades (values {:uuid uuid :user_id user-id :shop_id shop-id :share_id share-id :grader grader :grade_amount grade
                                 :end_time (+ current-time default-grade-term) :grade_time current-time}))
    )
  )
;;获取会员的积分总览：总积分、已消费积分、将过期积分（积分有效期120天[120 * 24 * 60 * 60 * 1000毫秒]）
(defn get-user-total-grade [user-id]
  (if-let [total-grade (first (select user-profiles (fields :grade_amount :grade_used) (where {:user_id user-id})))]
    (assoc total-grade
      :grade_exceed
      (if-let [grade-excedd (first (exec-raw ["select sum(grade_amount-grade_used) as grade_exceed from e_user_grade where user_id = ? and end_time <= ? "
                                              [user-id (+ (System/currentTimeMillis) default-grade-remind-term)]] :results))]
        (:grade_exceed grade-excedd) 0))
    {:grade_amount 0 :grade_used 0 :grade_exceed 0}
    )
  )
(defn get-user-grade-items [user-id]
  (select user-grades (fields :uuid :grade_time :end_time :grade_amount :grade_used :grader :shop_id [:e_shop.name :shop_name])
          (join shops (= :e_shop.uuid :shop_id))
          (where {:user_id user-id})
          )
  )
