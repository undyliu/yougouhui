(ns yougou.user
  (:use 
		[korma.core]
		[yougou.db]
		)
)

(defn register-user [name phone pwd photo]
  (let [uuid (str (java.util.UUID/randomUUID))]
	(insert users (values {:uuid uuid :name name :phone phone :pwd pwd :photo photo}))
  {:uuid uuid})
)