define([], function () {
	return{
		show: function () {
			require(["jquerymobile", "auth", "utils", "views/HomePage"]
				, function (JMobile, Auth, Utils, HomePage) {
			
				$("[data-role='header']").toolbar();
				$('#app-footer').css('display', 'none');
				Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), []);
				
				//登录点击事件
				$("#formLogin").on("click", function () {
					$.mobile.loading("show", {text: '正在登陆...'});
					var loginData = {
						phone: $('#phone').val(),
						pwd: $('#password').val(),
						autoLogin: $("#autoLogin").get(0).selectedIndex == 0 ?false : true,
						rememberPwd: $("#rememberPwd").get(0).selectedIndex == 0 ?false : true
					};
				
					var authed = Auth.login(loginData);
					if(authed){
						HomePage.init(HomePage.show);
					}
					$.mobile.loading("hide");
				});
				
				document.getElementById('loadingDiv').style.display = "none";
			});
		}
	};
});