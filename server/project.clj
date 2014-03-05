(defproject yougou "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [compojure "1.1.6"]
								[org.clojure/data.json "0.2.4"]
								[org.clojure/java.jdbc "0.2.3"]
								[korma "0.3.0-RC6"]
								[mysql/mysql-connector-java "5.1.25"]
								[pandect "0.3.0"]
		]
  :plugins [[lein-ring "0.8.10"]]
  :ring {:handler yougou.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring-mock "0.1.5"]]}})
