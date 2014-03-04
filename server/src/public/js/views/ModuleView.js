
define([ "jquery", "backbone", "routers/dispatcher" ], function( $, Backbone, Dispatcher ) {

    var ChannelView = Backbone.View.extend( {
        initialize: function() {
            this.collection.on( "added", this.render, this );
        },

        render: function() {
            this.template = _.template( $( "script#moduleItems" ).html(), { "collection": this.collection } );            
            this.$el.find("ul").html(this.template);
            	
						_.each( this.collection.toJSON(), function( module, id ) {
							if(module.url){
								$.mobile.loadPage(module.url, {prefetch: true});//预加载对应的html
							}
						});
						
						var exceptionIds = null;
						var router = null;
						if(this.collection.type == 'discover'){
							router = Dispatcher.getRouter('DiscoverRouter');
							exceptionIds = ['radar'];
						}else if(this.collection.type == 'me'){
							router = Dispatcher.getRouter('UserProfileRouter');
							exceptionIds = ['settings', 'my_shop'];
						}
						if(router){
							router.addViews(this.collection.toJSON(), exceptionIds);
						}
						
						//对条目增加点击事件
						$( ".module-li" ).on( "click", function() {
								var code = $(this).jqmData("code");
								var name = $(this).jqmData("title");
								//var router = Dispatcher.getRouter('DiscoverRouter');
								if(router){
									router.navigate(router.routerPrefix + "?" + code, {trigger: true, replace: true});//触发路由
								}
						});

            return this;
        }

    } );

    return ChannelView;

} );