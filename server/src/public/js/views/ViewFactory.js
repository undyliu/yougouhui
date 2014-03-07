
/**
 *	路由统一的分配器
 */
define(["collections/FriendGroupCollection", "views/FriendGroupView", "collections/NearbyShopCollection", "views/NearbyShopListView", "collections/NearbyDiscountCollection", "views/NearbyDiscountListView", "models/RadarModel", "views/RadarView", "models/SettingsModel", "views/SettingsView", "models/ShopModel", "views/ShopView", "models/ShareModel", "views/ShareView", "collections/ContactCollection", "views/ContactListView", "collections/FavoriteCollection", "views/FavoriteListView", "collections/ShareCollection", "views/ShareListView"],
	function (FriendGroupCollection, FriendGroupView, NearbyShopCollection, NearbyShopListView, NearbyDiscountCollection, NearbyDiscountListView, RadarModel, RadarView, SettingsModel, SettingsView, ShopModel, ShopView, ShareModel, ShareView, ContactCollection, ContactListView, FavoriteCollection, FavoriteListView, ShareCollection, ShareListView) {
	var cachedViews = [];
	return {
		getView : function (type, viewModel) {
			for (var i = 0; i < cachedViews.length; i++) {
				if (cachedViews[i].type == type) {
					return cachedViews[i].view;
				}
			}

			var elData = viewModel.get('el_data');
			var modelData = viewModel.get('model_data');
			var collectionData = viewModel.get('collection_data');
			var view = null;

			if (type == 'friends') {
				view = new FriendGroupView({
						el : elData,
						collection : new FriendGroupCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'nearby_shops') {
				view = new NearbyShopListView({
						el : elData,
						collection : new NearbyShopCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'nearby_discount') {
				view = new NearbyDiscountListView({
						el : elData,
						collection : new NearbyDiscountCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'radar') {
				view = new RadarView({
						el : elData,
						model : new RadarModel(modelData)
					});
			} else if (type == 'settings') {
				view = new SettingsView({
						el : elData,
						model : new SettingsModel(modelData)
					});
			} else if (type == 'contact_list') {
				view = new ContactListView({
						el : elData,
						collection : new ContactCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'my_favorite') {
				view = new FavoriteListView({
						el : elData,
						collection : new FavoriteCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'my_share') {
				view = new ShareListView({
						el : elData,
						collection : new ShareCollection(collectionData.models, collectionData.options)
					});
			} else if (type == 'my_shop') {
				view = new ShopView({
						el : elData,
						model : new ShopModel(modelData)
					});
			} else if (type == 'share_publish') {
				view = new ShareView({
						el : elData,
						model : new ShareModel(modelData)
					});
			}

			if (view) {
				cachedViews.push({
					"type" : type,
					"view" : view
				});
			}
			return view;
		}
	};
});
