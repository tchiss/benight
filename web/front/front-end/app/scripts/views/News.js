define(['jquery',
        'underscore',
        'backbone',
        'templates'
], function($, _, Backbone, JST){
    'use strict'


    var NewsView = Backbone.View.extend({
    	template: JST['app/scripts/templates/news.ejs'],

    	el: '.content',

    	initialize: function()  {
    		_.bindAll(this, 'render');
    	},

    	render: function() {
    		this.$el.html(this.template());
            this.delegateEvents();
            return this;
    	}

    });

    return NewsView;
});