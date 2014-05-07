//主应用的入口js
require(["config", "../cordova", "db"], function (Conf, Cordova, DB) {
	var runMode = Conf.getRunMode();
	if (runMode === 'mobile') {
		var onDeviceReady = function () {
			navigator.splashscreen.show();//显示splash
			/*
			var db = window.sqlitePlugin.openDatabase("Database", "1.0", "Demo", -1);
			db.transaction(function (tx) {
				tx.executeSql('DROP TABLE IF EXISTS test_table');
				tx.executeSql('CREATE TABLE IF NOT EXISTS test_table (id integer primary key, data text, data_num integer)');

				tx.executeSql("INSERT INTO test_table (data, data_num) VALUES (?,?)", ["test", 100], function (tx, res) {
					console.log("insertId: " + res.insertId + " -- probably 1"); // check #18/#38 is fixed
					alert("insertId: " + res.insertId + " -- should be valid");

					db.transaction(function (tx) {
						tx.executeSql("SELECT data_num from test_table;", [], function (tx, res) {
							console.log("res.rows.length: " + res.rows.length + " -- should be 1");
							alert("res.rows.item(0).data_num: " + res.rows.item(0).data_num + " -- should be 100");
						});
					});

				}, function (e) {
					console.log("ERROR: " + e.message);
				});
			});
			*/
			DB.init();//初始化db
			
			require(["app"], function (App) {
				App.initApp();
			});
		};
		document.addEventListener('deviceready', onDeviceReady, false);
	} else {
		require(["app"], function (App) {
			App.initApp();
		});
	}

});
