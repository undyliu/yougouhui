//主应用的入口js
require(["config", "utils"], function (Conf, Utils) {	
	require(["app"], function (App) {
		App.initApp();
	});
});
