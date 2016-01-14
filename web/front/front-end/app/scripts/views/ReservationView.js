define(['jquery',
	'underscore',
	'backbone',
	'parse',
	'templates',
	'models/ReservationModel',
	'models/MyPartyEvent',
	'collections/ReservationCollection'
	], function($, _, Backbone, Parse, JST, ReservationModel, ReservationCollection){
		'use strict'

	var ReservationView = Backbone.View.extend({

		//template: JST['app/scripts/templates/PartyEvents.ejs'],
		
		template: JST['app/scripts/templates/reservation.ejs'],

		model: ReservationModel,

		tagName: 'li',

	    calssName: 'list-group-item',

	    // The DOM events specific to an item.

	    initialize: function(){
	    	_.bindAll(this, 'render');
	    	this.render();
	    },

	    render: function () {
	    	this.$el.html(this.template(this.model.toJSON()));
	    	return this;
	    }
	});

	return ReservationView;
});