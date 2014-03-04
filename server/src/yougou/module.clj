(ns yougou.module
  (:use 
		[korma.core]
		[yougou.db]
		)
)

(defn get-channels [parent-id] 
	(select channels (fields :uuid :code :name :url :desc :parent_id) 
					(where {:parent_id [= parent-id]}) 
					(order :ord_index))	
)

(defn get-modules [type]
	(select modules (fields :uuid :code :name :icon :desc :url)
			(where {:type [= type]})
			(order :ord_index)
	)
)