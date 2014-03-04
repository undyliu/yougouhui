/*
* 频道路由器
*/
define([ "jquery", "collections/ChannelCollection", "views/HomeTabView"], function( $, ChannelCollection, HomeTabView ) {
		
    return{
    	init: function(initOpts) {
    		var homeTabView = new HomeTabView({ el: ".home-page #homepage-tabs", collection: new ChannelCollection( [] , {} ) });
    		
    		if(!homeTabView.collection.length) {
    			homeTabView.collection.fetch(
    				{
    					success: function (collection, response, options) {
    						collection.trigger( "added" );
    						var success = initOpts.success;
    						if(success){
    							success(collection.toJSON());
    						}
    					},
    					error: function () {
    						alert("加载频道数据失败.")
    					}
    				}
    			).done( function() {
    			});	
    		}
    	}
    }

} );