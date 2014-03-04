
define([ "jquery","backbone", "collections/ModuleCollection", "views/ModuleView", "config", "utils"]
	, function( $, Backbone, ModuleCollection, ModuleView, appConf, Utils ) {

    var ModuleRouter = Backbone.Router.extend( {
		
        initialize: function() {
        	this.discoverView = new ModuleView({ el: "#discover", 
						collection: new ModuleCollection( [] , {"type": "discover" } ) });
            Backbone.history.start();
					this.meView = new ModuleView({ el: "#me", 
						collection: new ModuleCollection( [] , {"type": "me" } ) });
            //Backbone.history.start();
        },

        routes: {
            "module?:type": "module"
        },
				
        module: function(type) {
        	var currentView = this[ type + "View" ];
        	
        	//$('#main-back-link').attr("href", "#module?homepage");
        	$("#main-back-link").css("display","none");
        	$('#main-head-title').html(appConf.getAppTitle());
        	        	
        	Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), ['main-head-city-link', 'main-head-search-link']);
        	
        	if(currentView && !currentView.collection.length){
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
        			$.mobile.changePage( "#" + type , { reverse: false, changeHash: false } );
        		});
        		
        	}else{
            	$.mobile.changePage( "#" + type , { reverse: false, changeHash: false } );
            }
        }

    } );

    return ModuleRouter;

} );