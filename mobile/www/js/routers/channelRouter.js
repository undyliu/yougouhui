/*
 * 频道路由器
 */
define(["jquery", "collections/ActivityCollection", "views/ChannelView"], function ($, ActivityCollection, ChannelView) {

	var channelViews = [];

	return {
		init : function (channelJsonData) {
			$.each(channelJsonData, function (index, channel) {
				var id = channel.code;
				var view = new ChannelView({
						el : "#" + id,
						collection : new ActivityCollection([], {
							"channelCode" : id,
							"channelId" : channel.uuid,
							"channelName" : channel.name,
							"parentId" : channel.parent_id
						})
					});
				channelViews.push({
					"id" : id,
					"view" : view
				});
			});
		},

		route : function (channelCode) {
			var currentChannelView = null;
			for (var i = 0; i < channelViews.length; i++) {
				var obj = channelViews[i];
				if (obj.id == channelCode) {
					currentChannelView = obj.view;
					break;
				}
			}
			if (!currentChannelView) {
				return;
			}

			//if(!currentChannelView.collection.length)
			{
				$.mobile.loading("show");
				currentChannelView.collection.fetch({
					success : function (collection, response, options) {
						collection.trigger("added");
					},
					error : function () {
						$.mobile.loading("hide");
						alert("加载活动数据失败.");
					}
				}).done(function () {
					$.mobile.loading("hide");
				});
			}
		}
	};

});
