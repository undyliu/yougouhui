(ns yougou.file
	(:require
		[clojure.java.io :as io]
	)
)

(defn save-image-file [file-name tempfile]
	(let [path "upload/images"
				file (io/file path file-name)]
		(io/copy tempfile file)
		(println (str "save file:" (.getAbsolutePath file)))
	)
)

(defn get-image-file [file-name]
	(let [path "upload/images"
				file (io/file path file-name)]				
	file)
)

(defn del-image-files [files]
	(let [path "upload/images"]
		;(println (class files))
		(if (> (count files) 0)
			(loop [file-names files entry-name (first file-names)]
				(if entry-name
					(cond
						(instance? java.util.Map entry-name) (del-image-files (vals entry-name))
						(instance? java.lang.String entry-name) 
							(let [file-name entry-name] 
								(try
									(.delete (io/file path file-name))
									(println (str "delete file:" (.getAbsolutePath (io/file path file-name))))
									(catch Exception e (.printStackTrace e))
								)
							)
						:else (println (str "del-image-file args type:" (class entry-name)))
					)
				)	
				(if (> (count file-names) 0)
					(recur (rest file-names) (first (rest file-names)))
				)
			)
		)
	)
)