
define([ "jquery", "backbone", "views/BackCollectionView", "routers/dispatcher", "utils" ]
	, function( $, Backbone, CallbackView, Dispatcher, Utils ) {

    var View = CallbackView.extend( {
    		constructor:function(options) {
    			View.__super__.constructor.call(this, options);
    		},
    		
        initialize: function() {
            View.__super__.initialize.call(this);
        },

        render: function() {
          this.constructor.__super__.render.call(this);
          
          var btnId = 'main-head-publish-link';          
          var publishBtnItem = $('#' + btnId);
          if(publishBtnItem && publishBtnItem.length > 0){
          	publishBtnItem.css("display", "block");
          }else{
          	var publishBtnHtml = '<a id="' + btnId + '" class="top-header ui-btn ui-btn-inline ui-corner-all ui-icon-camera ui-btn-icon-left">晒单</a>';
          	$('#main-head-search-link').after(publishBtnHtml);
          	$.mobile.loadPage('share_publish.html', {prefetch: true});//预加载对应的html
          }          
          
          $( "#" + btnId).on( "click", function() {
          	var router = Dispatcher.getRouter('DiscoverRouter');
          	if(router){
          		router.navigate(router.routerPrefix + "?share_publish", {trigger: true, replace: true});//触发路由
          	}
          });
            
          Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), [btnId]);
					
					$( ".friends-img-link").on( "click", function() {
						Utils.openPopDiv("", $(this));
					});
					
          return this;
        }

    } );

    return View;

} );