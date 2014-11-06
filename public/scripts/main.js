require.config({
	baseUrl: "./scripts/",
	paths:{
		"jquery": "vendor/jquery/dist/jquery.min",
		"underscore": "vendor/underscore-amd/underscore-min",
		"backbone": "vendor/backbone-amd/backbone-min"
	}
});


require(['app'], function(AppRouter){
	new AppRouter;
});