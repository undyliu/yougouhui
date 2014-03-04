
define([ "jquery", "backbone" ], function( $, Backbone ) {

    var CallbackView = Backbone.View.extend( {
        initialize: function() {
        
          this.collection.on( "added", this.render, this );
        },

        render: function() {
        	$('#main-back-link').attr("href", this.collection.backHref);
        	$("#main-back-link").css("display","block");
        	$('#main-head-title').html(this.collection.title);
          
          return this;
        }

    } );

    return CallbackView;

} );