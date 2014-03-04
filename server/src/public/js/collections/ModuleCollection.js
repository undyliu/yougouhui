
define([ "jquery","backbone","models/CommonModel", "config" ], function( $, Backbone, CommonModel, appConf ) {

    var Collection = Backbone.Collection.extend( {

        initialize: function( models, options ) {
					this.type = options.type;
        },

        model: CommonModel,
        
        url: function () {
        	return appConf.getBaseUrl() + "/getModules/" + this.type;
        }
        
    } );

    return Collection;

} );