define(['jquery',
        'underscore',
        'backbone',
        'parse',
        'templates',
        'views/Login',
        'views/EventsCollectionView'
], function($, _, Backbone, Parse, JST, LoginView, EventsCollectionView){
    'use strict'

    var currentUser = Parse.User.current();

    var HomeView = Backbone.View.extend({

    	template: JST['app/scripts/templates/home.ejs'],

    	el: '.elements',

    	events: {
    		"click .log-out": "logOut",
    		//"click .news-section": "news",
    		"click .events-section": "listEvents"
    	},

    	initialize: function(){
    		_.bindAll(this, 'render', 'logOut', 'listEvents');
    		this.render();
    	},

    	logOut: function(e){
            Parse.User.logOut();
            this.remove();
            this.unbind();
    		this.undelegateEvents();
    		delete this;
    	},

/*    	news: function(e){
    		console.log("what's new");
    		new NewsCollectionView();
    		this.undelegateEvents();
    		delete this;
    	},
*/
    	listEvents: function(e){
    		/*var EventsCollection = new EventsCollectionView();
    		EventsCollection.render();
    		this.undelegateEvents();
    		delete this;*/
    	},

        close: function() {
            $(this.el).empty();
        },

    	render: function(){
    		this.$el.html(this.template());
    		return this;
    	}
    });

    return HomeView;
});