define(["jquery","backbone","env","views/LoginPage","views/HomePage"],function(c,e,b,a,d){if(b.getProperty("rememberPwd")){c("#phone").val(b.getProperty("phone"));c("#password").val(b.getProperty("pwd"));c("#rememberPwd").get(0).selectedIndex=1}if(b.getProperty("autoLogin")){c("#autoLogin").get(0).selectedIndex=1}c("#main-head-title").html(b.getAppTitle());return{initApp:function(){c(document).on("mobileinit",function(){c.mobile.linkBindingEnabled=false;c.mobile.hashListeningEnabled=false;c.support.cors=true;c.mobile.allowCrossDomainPages=true});if(!b.getProperty("autoLogin")){a.show()}else{var f=a.auth();if(f){d.init(d.show)}else{a.show()}}}}});