'use strict';
define(['jquery',
        'underscore',
        'backbone',
        'parse',
        'templates'
], function($, _, Backbone, Parse, JST) {

	var homeView = Backbone.View.extend({
		el: '#container',
		template: JST['script/../index.html'],

		initialize: function(){

		},

		render: function(){
			$(this.el).html(_.template(this.template));
		}
	});
})