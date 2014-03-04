
define([ "jquery","backbone", "collections/ActivityCollection", "views/ChannelView"], function( $, Backbone, ActivityCollection, ChannelView) {
		var subChannelViews = new Array();
    var SubChannelRouter = Backbone.Router.extend( {

        initialize: function() {
        },

        routes: {
            "subChannel?:id": "channel"        
        },
		
        channel: function(id) {
        	var currentView = null;
        	for(var i = 0; i < subChannelViews.length; i++){
        		var obj = subChannelViews[i];
        		if(obj.id == id){
        			currentView = obj.view;
        			break;
        		}
        	}
        	if(!currentView){
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
        				alert("加载活动数据失败.")
        			}
        		}
        	).done( function() {
        		$.mobile.loading( "hide" );
						//$.mobile.navigate("#subChannel?" + code);
        		$.mobile.changePage( "#subChannel", { reverse: false, changeHash: false } );
        	});	
            
        },
        
				addViews: function (jsonData) {
					$.each(jsonData, function (index, subChannel) {
						var id = subChannel["uuid"];
						var view = new ChannelView({ el: "#subChannel", collection: new ActivityCollection( [] , { "channelCode": subChannel['code'], "channelId" : id, "channelName" : subChannel['name'], "parentId": subChannel['parent_id'] } ) });
						subChannelViews.push({"id" : id, "view" : view});
					});
				}
    } );

    return SubChannelRouter;

} );