(ns yougou.setting
  (:use
		[korma.core]
		[yougou.db]
		)
)

(defn get-settings []
	(select settings (fields :uuid :code :name :img :ord_index) (where {:is_used 1}))
)
