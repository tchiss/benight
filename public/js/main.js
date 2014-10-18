'use strict';

require.config({
	paths:{
		jquery: 'lib/jquery',
		underscore: 'lib/underscore',
		backbone: 'lib/backbone'
	}
});

require([
	'app',
	'router',
], function(App){
	App.initialize();
});


/*$(document).ready(function() {
  // Place JavaScript code here...
	new AppRouter();
	Backbone.history.start();
});*/
