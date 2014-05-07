define(["jquery", "backbone"], function ($, Backbone) {

	var Model = Backbone.Model.extend({
			defaults : {
				el_data : null,
				collection_data : {
					models : [],
					options : {}
				},
				model_data : {}
			}
		});

	// Returns the Model class
	return Model;

});
