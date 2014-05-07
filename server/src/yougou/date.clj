(ns yougou.date
)

(defn formatDate [time]
	(.format (java.text.SimpleDateFormat. "yyyy-MM-dd") (java.util.Date. time)
	)
)

(defn formatTime [time]
  (.format (java.text.SimpleDateFormat. "yyyy-MM-dd HH:mm:ss") (java.util.Date. time)
	)
 )
