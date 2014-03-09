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
			  		}else{//认证成功，更新本地的用户信息
			  			DB.executeSql('select pwd from e_user where phone = ? ', [loginData.phone], function (tx, res) {
							if(res && res.rows && res.rows.length === 1){
								DB.executeSql(' update e_user set pwd = ? where phone = ?', [loginData.pwd, loginData.phone]);
							}else{
								DB.executeSql(' insert into e_user(pwd, phone) values(?, ?)', [loginData.pwd, loginData.phone]);
							}
						}, function (e) {
							console.log("ERROR: " + e.message);
						});
			  		}
			  	},
			  	error: function (XMLHttpRequest, textStatus, errorThrown) {
			  		alert('无法连接服务器.');
			  	} 
				});
			}
			
			if(authed){
				DB.executeSql('select data from e_env', [], function (tx, res) {
					if(res && res.rows && res.rows.length === 1){
						DB.executeSql(' update e_env set data = ? where id = 1', [loginData]);
					}else{
						DB.executeSql(' insert into e_env(id, data) values(?, ?)', [1, loginData]);
					}
				}, function (e) {
					console.log("ERROR: " + e.message);
				});//记录登录信息
			}
			return authed;
		}
	};
});