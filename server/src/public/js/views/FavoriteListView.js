
define([ "jquery", "backbone", "views/BackCollectionView", "utils" ]
	, function( $, Backbone, CallbackView, Utils ) {
		
		var activedTabId = 'my_favorite_shop';
    var View = CallbackView.extend( {
    		constructor:function(options) {
    			View.__super__.constructor.call(this, options);
    		},
    		
        initialize: function() {
            View.__super__.initialize.call(this);
        },

        render: function() {
          this.constructor.__super__.render.call(this);
          
          var btnId = 'main-head-favorite-refresh-link';
          var scanBtnItem = $('#' + btnId);
          if(scanBtnItem && scanBtnItem.length > 0){
          	scanBtnItem.css("display", "block");
          }else{
          	var scanBtnHtml = '<a id="' + btnId + '" href="#" class="top-header ui-btn ui-btn-inline ui-corner-all ui-icon-refresh ui-btn-icon-left">刷新</a>';
          	$('#main-head-search-link').after(scanBtnHtml);
          }
              
          Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), [btnId]);
          
          $(document).on("tabsbeforeactivate", "#my_favorite [data-role='tabs']", function (event, ui) {
          	activedTabId = ui.newPanel.attr('id')          	
          });
          
          $( "#my_favorite [data-role='tabs'] [href='#" + activedTabId + "']" ).addClass("ui-btn-active");
          
          return this;
        }

    } );

    return View;

} );