
define([ "jquery", "backbone", "views/BackModelView", "utils", "config" ]
	, function( $, Backbone, CallbackView, Utils, appConf ) {

    var View = CallbackView.extend( {
    		constructor:function(options) {
    			View.__super__.constructor.call(this, options);
    		},
    		
        initialize: function() {
          View.__super__.initialize.call(this);
        },

        render: function() {       	
          this.constructor.__super__.render.call(this);  
          Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), []);
          
          //商品折扣基本信息
          this.template = _.template( $( "script#activityItem" ).html(), 
						{ "activity": this.model, "baseUrl": appConf.getBaseUrl() } );            
          this.$el.find('[role="main"] #activity-content').html(this.template);
          
          //点评信息
          this.template = _.template( $( "script#discussItems" ).html(), { "collection": this.model.get('discusses') } );            
          this.$el.find("#activity-discuss-list").html(this.template);
          this.$el.find("#activity-discuss-list").listview( "refresh" );
          
          return this;
        }

    } );

    return View;

} );