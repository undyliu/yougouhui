define(["auth"], function (Auth) {
	var authFunc = function (success) {
		//$.mobile.loading("show", {text: '正在登陆...'});
		var loginData = {
			phone: $('#phone').val(),
			pwd: $('#password').val(),
			autoLogin: $("#autoLogin").get(0).selectedIndex == 0 ?false : true,
			rememberPwd: $("#rememberPwd").get(0).selectedIndex == 0 ?false : true
		};
		
		var authed = Auth.login(loginData);
		//$.mobile.loading("hide");
		
		if(authed && success){
			success();
		}
		return authed;
	};
	return{
		show: function () {
			require(["jquerymobile", "utils", "views/HomePage"]
				, function (JMobile, Utils, HomePage) {
			
				$("[data-role='header']").toolbar();
				$('#app-footer').css('display', 'none');
				Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), []);
				
				//登录点击事件
				$("#formLogin").on("click", function () {
					var authed = authFunc();
					if(authed){
						HomePage.init(HomePage.show);
					}
				});
				
				document.getElementById('loadingDiv').style.display = "none";
			});
		},
		auth: function () {
			return authFunc();
		}
	};
});