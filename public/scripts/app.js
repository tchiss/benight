define(['jquery', 'underscore', 'backbone'], function($, _, Backbone){
	var App = Backbone.Router.extend({
		routes: {
			'': 'index',
			'events': 'listEvents',
			'events/:id': 'singleEvent'
		},

		index: function(){
			console.log('The router is running');
		},
		listEvents: function(){
			console.log('The router is running listEvents');
		},	
		singleEvent: function(){
			console.log('The router is running singleEvent');
		}
	});

	Backbone.history.start();

	return App;
});