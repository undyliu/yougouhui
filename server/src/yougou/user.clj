(ns yougou.user
  (:use
		[korma.core]
		[yougou.db]
	)
	(:require
		[yougou.file :as file]
	)
)

(defn register-user [name phone pwd type photo temp-file]
  (let [uuid (str (java.util.UUID/randomUUID))
			register-time (str (System/currentTimeMillis))]
		(insert users (values {:uuid uuid :name name :phone phone :pwd pwd :photo photo :type type :register_time register-time}))
		(if temp-file
			(file/save-image-file photo temp-file)
		)
  {:uuid uuid :register_time register-time})
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
