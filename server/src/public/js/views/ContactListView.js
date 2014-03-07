
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

				var btnId = 'main-head-contact-add-link';
				var scanBtnItem = $('#' + btnId);
				if (scanBtnItem && scanBtnItem.length > 0) {
					scanBtnItem.css("display", "block");
				} else {
					var scanBtnHtml = '<a id="' + btnId + '" href="#" class="top-header ui-btn ui-btn-inline ui-corner-all ui-icon-plus ui-btn-icon-left">添加</a>';
					$('#main-head-search-link').after(scanBtnHtml);
				}

				Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), [btnId]);

				return this;
			}

		});

	return View;

});
