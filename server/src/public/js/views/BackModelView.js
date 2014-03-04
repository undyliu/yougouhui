
define([ "jquery", "backbone" ], function( $, Backbone ) {

    var CallbackView = Backbone.View.extend( {
        initialize: function() {        
          this.model.on( "added", this.render, this );
        },

        render: function() {
        	var title = this.model.get('title');
        	if(!title){
        		title = this.model.title;
        	}
        	$('#main-back-link').attr("href", this.model.backHref);
        	$("#main-back-link").css("display","block");
        	$('#main-head-title').html(title);
          
          return this;
        }

    } );

    return CallbackView;

} );