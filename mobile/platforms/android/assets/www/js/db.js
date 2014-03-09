define(['config'], function (Conf) {
  var db = null;
  var local = Conf.getRunMode() === 'mobile';
	return {
		init: function () {
			if(local){
				db = window.sqlitePlugin.openDatabase("Database", "1.0", "YouGou", -1);
			}
		},
		
		executeSql: function (sql, parameterArray, success, error) {
			if(local){
				if(db === null){
					db = window.sqlitePlugin.openDatabase("Database", "1.0", "YouGou", -1);
				}
			
				db.transaction(function (tx) {
					tx.executeSql(sql, parameterArray, success, error);
				});
			}else{
				
			}
		}
	};
});