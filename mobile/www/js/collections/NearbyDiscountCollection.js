define(["jquery", "backbone", "collections/DiscoverCollection", "config"], function ($, Backbone, DiscoverCollection, appConf) {

	var Collection = DiscoverCollection.extend({

			constructor : function (models, options) {
				Collection.__super__.constructor.call(this, models, options);
			},

			initialize : function (models, options) {
				Collection.__super__.initialize.call(this, models, options);
			},

			url : function () {
				var session = appConf.getSession();
				return appConf.getBaseUrl() + "/getNearbyDiscounts/" + session.svGEO;
			}

		});

	return Collection;

});
