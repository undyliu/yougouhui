
define([ "jquery", "backbone", "models/BackSupportModel", "config"], function( $, Backbone, BackSupportModel, appConf ) {

    var Model = BackSupportModel.extend( {			
			constructor:function(options) {
				Model.__super__.constructor.call(this, options);
			},
			
			initialize: function(options) {
				options.backHref = '#module?homepage';
			  Model.__super__.initialize.call(this, options);
			},
			
			url: function () {
				return appConf.getBaseUrl() + "/getActiveData/" + this.id;
			},
			
			parse: function(resp, xhr) {
				if(resp.length > 0){
					return resp[0];
				}
			  return resp;
			}
    } );

    return Model;

} );