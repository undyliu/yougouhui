
define(["jquery", "backbone", "models/ActivityModel", "views/ActivityView"]
	, function ($, Backbone, ActivityModel, ActivityView) {

	var ActivityRouter = Backbone.Router.extend({

			initialize : function () {
				
			},

			routes : {
				"activity?:id" : "activity"
			},

			activity : function (id) {			  	
				activityView = new ActivityView({el: "#activity"
					, model: new ActivityModel({id: id, title: id})});
				
				$.mobile.loading( "show" );
				activityView.model.fetch(
					{
						success: function (model, response, options) {
							model.trigger( "added" );
						},
						error: function () {
							$.mobile.loading( "hide" );
							alert("加载活动数据失败.")
						}
					}
				).done( function() {
					$.mobile.loading( "hide" );
					$.mobile.changePage( "#activity", { reverse: false, changeHash: false } );
				});	
			}

		});

	return ActivityRouter;

});
