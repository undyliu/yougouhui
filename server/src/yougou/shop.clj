(ns yougou.shop
  (:use 
		[korma.core]
		[yougou.db]
	)
)

(defn get-trades []
	(select trades (fields :uuid :code :name) (where {:is_used [= 1]}) (order :ord_index))
)