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
