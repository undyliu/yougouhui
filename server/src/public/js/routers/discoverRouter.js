define([ "jquery","backbone", "models/CommonViewModel", "views/ViewFactory"
	, "routers/identyRouter"]
	, function( $, Backbone, CommonViewModel, ViewFactory, IdentyRouter) {
	
	var DiscoverRouter = IdentyRouter.extend( {
		constructor:function() {
			DiscoverRouter.__super__.constructor.call(this);
		},
		
		initialize: function() {
			DiscoverRouter.__super__.initialize.call(this);
			this.routerPrefix = 'discover';
			
			var viewModel = new CommonViewModel({
				el_data: '#radar',
				model_data: {'title': '雷达'}
			});
			this.radarView = ViewFactory.getView('radar', viewModel);
			
			viewModel = new CommonViewModel({
				el_data: '#share_publish',
				model_data: {'title': '晒单'}
			});
			this.shareView = ViewFactory.getView('share_publish', viewModel);
		},
		
		routes: {
			"discover?radar": "radar",
			"discover?share_publish": "share_publish",
    	"discover?:code": "identy"
    },
		
		radar: function () {
			this.radarView.render();
			$.mobile.changePage( "#radar" , { reverse: false, changeHash: false } );
		},
		
		share_publish: function () {
			this.shareView.render();
			$.mobile.changePage( "#share_publish" , { reverse: false, changeHash: false } );
		}
	});
	return DiscoverRouter;
});