define([
	'jquery',
	'backbone',
	'underscore'
	], function($, Backbone, _){
		var AppRouter = Backbone.Router.extend({
			routes: {
				'/BenightEvents': 'BenightEvents',
				'BenightEvents/:id' 'BenightEventsById'
				'*actions': '/BenightDefault'
			}
		});
		initialize: function(){
			var 	r = new AppRouter;
			console.log("initialize router ok !");
		}
		BenightEvents: function(){
			console.log('Yes it works');
		},
		BenightEventsById: function(){
			console.log('Yes it still works');
		}
	return {
		initialize: initialize
});

Backbone.history.start({pushState: true});