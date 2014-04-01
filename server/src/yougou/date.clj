(ns yougou.date
)

(defn formatDate [time]
	(.format (java.text.SimpleDateFormat. "yyyy-MM-dd") (java.util.Date. time)
	)
)