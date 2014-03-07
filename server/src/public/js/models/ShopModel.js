
define(["jquery", "backbone", "models/BackSupportModel", "config"], function ($, Backbone, BackSupportModel, appConf) {

	var Model = BackSupportModel.extend({
			defaults : {},

			constructor : function (options) {
				Model.__super__.constructor.call(this, options);
			},

			initialize : function (options) {
				options.backHref = '#module?me';
				Model.__super__.initialize.call(this, options);
			},

			url : function () {
				return appConf.getBaseUrl() + "/settings/";
			}
		});

	return Model;

});
