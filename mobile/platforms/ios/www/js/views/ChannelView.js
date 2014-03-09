
define(["jquery", "backbone", "config", "routers/dispatcher"], function ($, Backbone, appConf, Dispatcher) {

	var ChannelView = Backbone.View.extend({
			initialize : function () {
				this.collection.on("added", this.render, this);
			},

			render : function () {
				if (this.collection.channelCode == 'other') {
					this.template = _.template($("script#subChannelItems").html(), {
							"collection" : this.collection
						});
					var router = Dispatcher.getRouter('SubChannelRouter');
					if (router) {
						router.addViews(this.collection.toJSON());
					}
				} else {
					this.template = _.template($("script#activityItems").html(), {
							"collection" : this.collection,
							"baseUrl" : appConf.getBaseUrl()
						});
					if (this.collection.parentId) {
						$('#main-back-link').attr("href", "#module?homepage");
						$("#main-back-link").css("display", "block");
						$('#main-head-title').html(this.collection.channelName);
					}
				}

				try {
					this.$el.find("ul").html(this.template);
					this.$el.find("[data-role='listview']").listview("refresh");
				} catch (error) {}
				return this;

			}

		});

	return ChannelView;

});
