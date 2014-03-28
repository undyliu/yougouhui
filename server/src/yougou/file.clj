(ns yougou.file
	(:require
		[clojure.java.io :as io]
	)
)

(defn save-image-file [file-name tempfile]
	(let [path "upload/images"
				file (io/file path file-name)]
		(io/copy tempfile file)
		(println (.getAbsolutePath file))
	)
)

(defn get-image-file [file-name]
	(let [path "upload/images"
				file (io/file path file-name)]
				
	file)
)

(defn del-image-files [files]
	(let [path "upload/images"]
		(loop [file-names files]
			(when (> (count file-names) 0)
				(try
					(.delete (io/file path (first file-names)))
					(catch Exception e (.printStackTrace e))
				)
				(recur (rest file-names))
			)
		)
	)
)