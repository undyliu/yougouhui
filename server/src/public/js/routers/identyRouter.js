/*
*通用的基于code进行路由
*/
define([ "jquery","backbone", "models/CommonViewModel", "views/ViewFactory"], function( $, Backbone, CommonViewModel, ViewFactory) {
	var views = new Array();
	
	var Router = Backbone.Router.extend( {
		initialize: function() {
		},
				
		identy: function(code){
			var currentView = null;
			for(var i = 0; i < views.length; i++){
				var obj = views[i];
				if(obj.code == code){
					currentView = obj.view;
					break;
				}
			}
			if(!currentView){
				$.mobile.changePage( "#" + code , { reverse: false, changeHash: false } );
				return;
			}
			
			
			$.mobile.loading( "show" );
			currentView.collection.fetch(
					{
						success: function (collection, response, options) {
							collection.trigger( "added" );
						},
						error: function () {
							$.mobile.loading( "hide" );
							alert("加载数据失败.")
						}
					}
				).done( function() {
					$.mobile.loading( "hide" );
					$.mobile.changePage( "#" + code , { reverse: false, changeHash: false } );
			});
				
		},
		
		addViews: function (jsonData, exceptionIds) {
			$.each(jsonData, function (index, rowData) {
				var except = false;
				var id = rowData["code"];
				if(exceptionIds){
					for(var i = 0; i < exceptionIds.length; i++){
						if(id == exceptionIds[i]){
							except = true;
							break;
						}
					}
				}
				if(!except){				
					var viewModel = new CommonViewModel({
						el_data: "#" + id,
						collection_data: {
							models:[],
							options:{
								"title": rowData["name"]
							}
						}
					});
					var view = ViewFactory.getView(id, viewModel);
					if(view){
						views.push({"code" : id, "view" : view});
					}
				}
			});
		}
	});
	return Router;
});