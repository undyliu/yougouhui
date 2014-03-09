
define(["jquery", "backbone", "models/CommonModel", "config"], function ($, Backbone, CommonModel, appConf) {

	var Collection = Backbone.Collection.extend({

			initialize : function (models, options) {},

			model : CommonModel,

			url : function () {
				return appConf.getBaseUrl() + "/getActiveChannels";
			}

		});

	return Collection;

});
