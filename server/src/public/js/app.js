
define(["jquery", "backbone", "env", "views/LoginPage", "views/HomePage"],
	function ($, Backbone, Env, LoginPage, HomePage) {
	
	if(Env.getProperty('rememberPwd')){//记住密码
		$('#phone').val(Env.getProperty('phone'));
		$('#password').val(Env.getProperty('pwd'));
		$("#rememberPwd").get(0).selectedIndex = 1;
	}
	
	if(Env.getProperty('autoLogin')){//自动登录
		$("#autoLogin").get(0).selectedIndex = 1;
	}
	$('#main-head-title').html(Env.getAppTitle());
	
		
	return {
		initApp : function () {
			$(document).on("mobileinit", function () {
				$.mobile.linkBindingEnabled = false;
				$.mobile.hashListeningEnabled = false;

				$.support.cors = true;
				$.mobile.allowCrossDomainPages = true;
			});
			
			if(!Env.getProperty('autoLogin')){//显示登陆界面				
				LoginPage.show();
			}else{
				HomePage.init(HomePage.show);
			}
		}
	};
});
