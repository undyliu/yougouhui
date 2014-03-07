
define(["jquery", "backbone", "models/CommonModel", "config"], function ($, Backbone, CommonModel, appConf) {

	var Collection = Backbone.Collection.extend({

			initialize : function (models, options) {
				this.channelCode = options.channelCode;
				this.channelId = options.channelId;
				this.channelName = options.channelName;
				this.parentId = options.parentId;
			},

			model : CommonModel,

			url : function () {
				if ('other' == this.channelCode) {
					return appConf.getBaseUrl() + "/getActiveChannels/" + this.channelId;
				} else {
					return appConf.getBaseUrl() + "/getActivities/" + this.channelId;
				}
			}

		});

	return Collection;

});
