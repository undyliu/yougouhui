
define(["jquery", "backbone"], function ($, Backbone) {

	var Collection = Backbone.Collection.extend({

			initialize : function (models, options) {
				this.title = options.title;
				this.backHref = options.backHref;
			}

		});

	return Collection;

});
