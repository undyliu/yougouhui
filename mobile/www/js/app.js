define(["jquery","backbone","routers/homeTabIniter","config"],function(c,d,b,a){return{initApp:function(){c(document).on("mobileinit",function(){c.mobile.linkBindingEnabled=false;c.mobile.hashListeningEnabled=false;c.support.cors=true;c.mobile.allowCrossDomainPages=true});b.init({success:function(e){c("#main-head-title").html(a.getAppTitle());require(["jquerymobile","routers/dispatcher","routers/channelRouter","utils","views/HtmlViewTemplate"],function(i,h,f,k,j){h.initRouters();f.init(e);var g="all";c(function(){c("[data-role='header'], [data-role='footer']").toolbar();c.mobile.loadPage("activity.html",{prefetch:true});c.mobile.loadPage("subChannel.html",{prefetch:true})});c("#main-head-search-link").on("click",function(){if(c("#popupSearch").length==0){var l=j.getSearchHtml();c.mobile.activePage.append(l).trigger("create");c("#searchWorld").css("width",c.mobile.activePage.width())}k.openPopDiv("#popupSearch",c(this))});c("#main-head-city-link").on("click",function(){k.openPopDiv("#popupSearch",c(this))});c(document).on("pageshow",".main-page",function(){var l=c(this).jqmData("title");c("[data-role='footer'] a.ui-btn-active").removeClass("ui-btn-active");c("[data-role='footer'] a").each(function(){if(c(this).text()===l){c(this).addClass("ui-btn-active")}});c(".home-page #homepage-tabs .tabs-fixed-header a.ui-btn-active").removeClass("ui-btn-active");c(".home-page #homepage-tabs .tabs-fixed-header [href='#"+g+"']").addClass("ui-btn-active")});c(document).on("tabsbeforeactivate",".home-page [data-role='tabs']",function(l,m){g=m.newPanel.attr("id");f.route(g)});c(".home-page #homepage-tabs .tabs-fixed-header [href='#all']").addClass("ui-btn-active");f.route("all");document.getElementById("loadingDiv").style.display="none"})}})}}});