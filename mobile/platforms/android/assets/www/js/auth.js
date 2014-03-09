define(["db", "jquery", "config"], function (DB, $, Conf) {

	var createUserSql = 'CREATE TABLE IF NOT EXISTS e_user (phone integer primary key, pwd text)';
	DB.executeSql(createUserSql);
	
	return {
		login: function (loginData) {			
			var authed = false;
			//根据本地数据库进行用户认证
			var getUserSql = ' select pwd from e_user where phone = ?';
			DB.executeSql(getUserSql, [loginData.phone], function (tx, res) {
				if(res && res.rows && res.rows.length === 1){
					if(res.rows.item(0).pwd == loginData.pwd){
						authed = true;
					}
				}
			}, function (e) {				
			});
			
			if(!authed){
				//进行远程认证
				$.ajax({
			  	type: "POST",
			  	async:false,
			  	dataType: 'json',
			  	url: Conf.getBaseUrl() + '/login',
			  	data: loginData,
			  	success: function (data) {
			  		authed = data.authed;
			  		if(!authed){
			  			var err_type = data['error-type'];
			  			if(err_type === 'user-error'){
			  				alert('手机号错误.');
			  			}else{
			  				alert('密码错误.');
			  			}
			  		}
			  	} 
				});
			}
			
			if(authed){
				var updateEnvSql = ' update e_env set data = ? where id = 1';
				DB.executeSql(updateEnvSql, [loginData]);//记录登录信息
			}
			return authed;
		}
	};
});