
define([ "jquery", "backbone", "models/BackSupportModel", "config"], function( $, Backbone, BackSupportModel, appConf ) {

    var Model = BackSupportModel.extend( {
			defaults:{
			},
			
			constructor:function(options) {
				Model.__super__.constructor.call(this, options);
			},
			
			initialize: function(options) {
				options.backHref = '#discover?friends';
				options.title = '晒单';
				
			  Model.__super__.initialize.call(this, options);
			},
			
			url: function () {
				return appConf.getBaseUrl() + "/settings/";
			}
    } );

    return Model;

} );