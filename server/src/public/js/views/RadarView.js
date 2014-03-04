
define([ "jquery", "backbone", "views/BackModelView", "utils" ]
	, function( $, Backbone, CallbackView, Utils ) {
		
		var activedTabId = 'radar_nearby_shop';
		
    var View = CallbackView.extend( {
    		constructor:function(options) {
    			View.__super__.constructor.call(this, options);
    		},
    		
        initialize: function() {
          View.__super__.initialize.call(this);
        },

        render: function() {
          View.__super__.render.call(this);
          
          var btnId = 'main-head-radar-scan-link';
          var scanBtnItem = $('#' + btnId);
          if(scanBtnItem && scanBtnItem.length > 0){
          	scanBtnItem.css("display", "block");
          }else{
          	var scanBtnHtml = '<a id="' + btnId + '" href="#" class="top-header ui-btn ui-btn-inline ui-corner-all ui-icon-recycle ui-btn-icon-left">扫一扫</a>';
          	$('#main-head-search-link').after(scanBtnHtml);
          }
              
          Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), [btnId]);
          
          $(document).on("tabsbeforeactivate", "#radar [data-role='tabs']", function (event, ui) {
          	activedTabId = ui.newPanel.attr('id')          	
          });
          
          $( "#radar [data-role='tabs'] [href='#" + activedTabId + "']" ).addClass("ui-btn-active");
          
          return this;
        }

    } );

    return View;

} );