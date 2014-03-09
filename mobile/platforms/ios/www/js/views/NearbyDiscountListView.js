
define(["jquery", "backbone", "views/BackCollectionView", "utils"], function ($, Backbone, CallbackView, Utils) {

	var View = CallbackView.extend({
			constructor : function (options) {
				View.__super__.constructor.call(this, options);
			},

			initialize : function () {
				View.__super__.initialize.call(this);
			},

			render : function () {
				this.constructor.__super__.render.call(this);

				Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), []);

				return this;
			}

		});

	return View;

});
