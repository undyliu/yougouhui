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
		(if (> (count files) 0)
			(loop [file-names files file-name (first file-names)]
					(try
						(.delete (io/file path file-name))
						(println (.getAbsolutePath (io/file path file-name)))
						(catch Exception e (.printStackTrace e))
					)
				(if (> (count file-names) 0)
					(recur (rest file-names) (first (rest file-names)))
				)
			)
		)
	)
)