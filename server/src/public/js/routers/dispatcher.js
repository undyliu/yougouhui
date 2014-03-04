
/**
 *	路由统一的分配器
 */
define(function(){
		var routers = {};
	  return { 
	    initRouters: function(){ 
	    	 require(["routers/moduleRouter", "routers/activityRouter", "routers/subChannelRouter"
					, "routers/discoverRouter", "routers/userProfileRouter"]
	    	 	, function (ModuleRouter, ActivityRouter, SubChannelRouter, DiscoverRouter, UserProfileRouter) {
	    	 		routers.ModuleRouter = new ModuleRouter();
	    	 		routers.ActivityRouter = new ActivityRouter();
	    	 		routers.SubChannelRouter = new SubChannelRouter();
						routers.DiscoverRouter = new DiscoverRouter();
						routers.UserProfileRouter = new UserProfileRouter();
	    	 	}); 
	    },
			getRouter: function(name){
				return routers[name];
			}
	 }; 
 });
