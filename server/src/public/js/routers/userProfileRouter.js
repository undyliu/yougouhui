define(["jquery", "backbone", "models/CommonViewModel", "views/ViewFactory", "routers/identyRouter"], function ($, Backbone, CommonViewModel, ViewFactory, IdentyRouter) {

	var UserProfileRouter = IdentyRouter.extend({
			constructor : function () {
				UserProfileRouter.__super__.constructor.call(this);
			},

			initialize : function () {
				UserProfileRouter.__super__.initialize.call(this);
				this.routerPrefix = 'userProfile';

				var viewModel = new CommonViewModel({
						el_data : '#settings',
						model_data : {
							'title' : '设置'
						}
					});
				this.settingsView = ViewFactory.getView('settings', viewModel);

				viewModel = new CommonViewModel({
						el_data : '#my_shop',
						model_data : {
							'title' : '我的店铺'
						}
					});
				this.shopView = ViewFactory.getView('my_shop', viewModel);
			},

			routes : {
				"userProfile?settings" : "settings",
				"userProfile?my_shop" : "myShop",
				"userProfile?:code" : "identy"
			},

			settings : function () {
				this.settingsView.render();
				$.mobile.changePage("#settings", {
					reverse : false,
					changeHash : false
				});
			},

			myShop : function () {
				this.shopView.render();
				$.mobile.changePage("#settings", {
					reverse : false,
					changeHash : false
				});
			}
		});
	return UserProfileRouter;
});
