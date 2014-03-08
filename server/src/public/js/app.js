
define(["jquery", "backbone", "routers/homeTabIniter", "env", "utils"],
	function ($, Backbone, HomeTabIniter, Env, Utils) {
	
	var openHomepage = function () {
		$("[data-role='footer']").toolbar();
		$('#app-footer').css('display', 'block');
		$.mobile.navigate( "#module?homepage" );
	};
	
	if(Env.getProperty('rememberPwd')){//记住密码
		$('#phone').val(Env.getProperty('phone'));
		$('#password').val(Env.getProperty('pwd'));
		$("#rememberPwd").get(0).selectedIndex = 1;
	}
	
	if(Env.getProperty('autoLogin')){//自动登录
		$("#autoLogin").get(0).selectedIndex = 1;
	}
		
	return {
		initApp : function () {
			$(document).on("mobileinit", function () {
				$.mobile.linkBindingEnabled = false;
				$.mobile.hashListeningEnabled = false;

				$.support.cors = true;
				$.mobile.allowCrossDomainPages = true;
			});

			HomeTabIniter.init({
				success : function (channelJsonData) {
					$('#main-head-title').html(Env.getAppTitle());

					require(["jquerymobile", "routers/dispatcher", "routers/channelRouter", "views/HtmlViewTemplate", "auth"], function (JMobile, Dispatcher, ChannelRouter, HtmlViewTemplate, Auth) {
						
						Dispatcher.initRouters();
						ChannelRouter.init(channelJsonData);
						var headerActivedTabId = 'all'; //记录当前活动的页签id

						$(function () {
							$("[data-role='header']").toolbar();
							$.mobile.loadPage('activity.html', {
								prefetch : true
							});
							$.mobile.loadPage('subChannel.html', {
								prefetch : true
							});
						});

						//登录点击事件
						$("#formLogin").on("click", function () {
							var loginData = {
								phone: $('#phone').val(),
								pwd: $('#password').val(),
								autoLogin: $("#autoLogin").get(0).selectedIndex == 0 ?false : true,
								rememberPwd: $("#rememberPwd").get(0).selectedIndex == 0 ?false : true
							};
						
							var authed = Auth.login(loginData);
							if(authed){
								openHomepage();
								var router = Dispatcher.getRouter('ModuleRouter');
								if (router) {
									router.navigate("module?homepage", {
										trigger : true,
										replace : true
									}); //触发路由
									ChannelRouter.route('all');
								}
							}
						});

						//搜索点击事件
						$("#main-head-search-link").on("click", function () {
							if ($('#popupSearch').length === 0) {
								var searchHtml = HtmlViewTemplate.getSearchHtml();
								$.mobile.activePage.append(searchHtml).trigger("create");
								$('#searchWorld').css('width', $.mobile.activePage.width());
							}
							Utils.openPopDiv("#popupSearch", $(this));
						});

						//地理位置点击事件
						$("#main-head-city-link").on("click", function () {
							Utils.openPopDiv("#popupSearch", $(this));
						});

						//设置活动页签的显示样式
						$(document).on("pageshow", ".main-page", function () {
							var title = $(this).jqmData("title");
							$("[data-role='footer'] a.ui-btn-active").removeClass("ui-btn-active");
							$("[data-role='footer'] a").each(function () {
								if ($(this).text() === title) {
									$(this).addClass("ui-btn-active");
								}
							});

							$(".home-page #homepage-tabs .tabs-fixed-header a.ui-btn-active").removeClass("ui-btn-active");

							$(".home-page #homepage-tabs .tabs-fixed-header [href='#" + headerActivedTabId + "']").addClass("ui-btn-active");

						});

						//监听页签的状态变化
						$(document).on("tabsbeforeactivate", ".home-page [data-role='tabs']", function (event, ui) {
							headerActivedTabId = ui.newPanel.attr('id');
							ChannelRouter.route(headerActivedTabId);
						});		
						
						if(Env.getProperty('autoLogin')){//自动登录
							var loginData = {
								phone: $('#phone').val(),
								pwd: $('#password').val(),
								autoLogin: $("#autoLogin").get(0).selectedIndex == 0 ?false : true,
								rememberPwd: $("#rememberPwd").get(0).selectedIndex == 0 ?false : true
							};
							
							var authed = Auth.login(loginData);
							if(authed){
								openHomepage();
								$(".home-page #homepage-tabs .tabs-fixed-header [href='#all']").addClass("ui-btn-active");
								ChannelRouter.route('all');
							}
						}else{
							$('#app-footer').css('display', 'none');
						}
										
						document.getElementById('loadingDiv').style.display = "none";
					});

				}
			});
		}
	};
});
