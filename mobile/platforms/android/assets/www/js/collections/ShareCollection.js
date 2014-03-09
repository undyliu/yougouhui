
define(["jquery", "backbone", "models/CommonModel", "collections/BackSupportCollection", "config"], function ($, Backbone, CommonModel, BackSupportCollection, appConf) {

	var Collection = BackSupportCollection.extend({

			constructor : function (models, options) {
				Collection.__super__.constructor.call(this, models, options);
			},

			initialize : function (models, options) {
				options.backHref = "#module?me";
				Collection.__super__.initialize.call(this, models, options);
			},

			model : CommonModel,

			url : function () {
				var session = appConf.getSession();
				return appConf.getBaseUrl() + "/getShareList/" + session.svUserId;
			}
		});

	return Collection;

});
