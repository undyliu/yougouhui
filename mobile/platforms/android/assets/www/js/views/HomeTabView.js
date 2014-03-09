
define(["jquery", "backbone"], function ($, Backbone) {

	var ChannelView = Backbone.View.extend({
			initialize : function () {
				this.collection.on("added", this.render, this);
			},

			render : function () {
				this.template = _.template($("script#channelItems").html(), {
						"collection" : this.collection
					});
				this.$el.find("ul").html(this.template);

				this.$el.append(_.template($("script#channelTabDivItems").html(), {
						"collection" : this.collection
					}));

				return this;
			}

		});

	return ChannelView;

});
