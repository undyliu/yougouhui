
define([ "jquery", "backbone" ], function( $, Backbone ) {

    var Model = Backbone.Model.extend( {
    
    	initialize: function(options ) {
    		this.title = options.title;
    		this.backHref = options.backHref;
    	}

    } );

    return Model;

} );