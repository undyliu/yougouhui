
define(["jquery", "backbone", "models/CommonModel", "collections/BackSupportCollection"], function ($, Backbone, CommonModel, BackSupportCollection) {

	var Collection = BackSupportCollection.extend({

			constructor : function (models, options) {
				Collection.__super__.constructor.call(this, models, options);
			},

			initialize : function (models, options) {
				options.backHref = "#module?discover";
				Collection.__super__.initialize.call(this, models, options);
			},

			model : CommonModel

		});

	return Collection;

});
