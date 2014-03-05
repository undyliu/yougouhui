
define(["jquery", "backbone", "routers/homeTabIniter", "config"], 
	function($, Backbone, HomeTabIniter, appConf){
	 
	 return {  
	 	initApp: function () {
	 		$(document).on("mobileinit", function () {
	 			$.mobile.linkBindingEnabled = false;
	 			$.mobile.hashListeningEnabled = false;
	 		
	 			$.support.cors = true;
	 			$.mobile.allowCrossDomainPages = true;
	 		});
						
	 		HomeTabIniter.init({
	 			success : function (channelJsonData) {
					$('#main-head-title').html(appConf.getAppTitle());
					
	 				require(["jquerymobile", "routers/dispatcher", "routers/channelRouter", "utils", "views/HtmlViewTemplate"]
							, function (JMobile, Dispatcher, ChannelRouter, Utils, HtmlViewTemplate) {
							Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), []);
	 						Dispatcher.initRouters();
	 						ChannelRouter.init(channelJsonData);
	 						var headerActivedTabId = 'all';//记录当前活动的页签id
	 						
	 						$(function () {
	 							$("[data-role='header'], [data-role='footer']").toolbar();
	 							$.mobile.loadPage('activity.html', {prefetch: true});
	 							$.mobile.loadPage('subChannel.html', {prefetch: true});
	 						});
	 						
							//登录点击事件
							$("#formLogin").on( "click", function() {
							  $('#app-footer').css('display','block');
								var router = Dispatcher.getRouter('ModuleRouter');
								router.navigate("module?homepage", {trigger: true, replace: true});
								$( ".home-page #homepage-tabs .tabs-fixed-header [href='#all']" ).addClass("ui-btn-active");
								ChannelRouter.route('all');
							});
							
							//搜索点击事件
							$( "#main-head-search-link" ).on( "click", function() {
								if($('#popupSearch').length == 0){
									var searchHtml = HtmlViewTemplate.getSearchHtml();
									$.mobile.activePage.append(searchHtml).trigger( "create" );
									$('#searchWorld').css('width', $.mobile.activePage.width());
								}
								Utils.openPopDiv("#popupSearch", $(this))
							});
							
							//地理位置点击事件
							$( "#main-head-city-link" ).on( "click", function() {								
								Utils.openPopDiv("#popupSearch", $(this))
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
	 							
	 							$( ".home-page #homepage-tabs .tabs-fixed-header [href='#" + headerActivedTabId + "']" ).addClass("ui-btn-active");
	 							
	 						});
	 							 						
	 						//监听页签的状态变化
	 						$(document).on("tabsbeforeactivate", ".home-page [data-role='tabs']", function (event, ui) {
	 							headerActivedTabId = ui.newPanel.attr('id')
	 							ChannelRouter.route(headerActivedTabId);
	 						});
							
							document.getElementById('loadingDiv').style.display = "none";
	 					});
	 					
	 			}
	 		});
	   }
	 }; 
 });
