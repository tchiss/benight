define(['underscore',
		'jquery',
		'backbone',
		'parse'
], function(_, $, Backbone, Parse){

    var HomeView = require('./views/home');
    
    var Router = Backbone.Router.extend({
        route: {
    		"": "home"
    	},
    	initialize: function(){
    		this.homeView = new HomeView();
    	},
    	home: function(){
    		this.homeView = new HomeView();
    		this.homeView.render();
    	}
    });
});