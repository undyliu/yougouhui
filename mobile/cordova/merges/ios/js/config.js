define(function () {
	var baseUrl = null;
	var runMode = "mobile";
	//var runMode = "pc";
	
	require.config({
		paths : {
			"jquery" : "libs/jquery",
			"jquerymobile" : "libs/jquery.mobile-1.4.0",
			"underscore" : "libs/lodash",
			"backbone" : "libs/backbone"
		},

		// Sets the configuration for your third party scripts that are not AMD compatible
		shim : {
			"backbone" : {
				"deps" : ["underscore", "jquery"],
				"exports" : "Backbone"
			}
		}
	});
	return {
		getBaseUrl : function () {
			if (!baseUrl) {
				//baseUrl = "http://223.203.193.239:7072/demo";
				 //baseUrl = "http://localhost:3000";
				baseUrl = 'http://192.168.1.103:3000';
				//baseUrl = $(location).attr('href').substring(0, $(location).attr('href').lastIndexOf("/"));
			}
			return baseUrl;
		},

		getAppTitle : function () {
			return "优购汇";
		},

		getSession : function () {
			return {
				svUserId : "1",
				svGEO : "1"
			};
		},
		
		getRunMode: function () {
			return runMode;
		}
	};
});
