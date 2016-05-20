define(['jquery',
        'underscore',
        'backbone',
        'models/MyPartyEvent',
        'views/PartyEvents',
        'collections/EventsCollection',
        'templates'
], function($, _, Backbone, PartyEventModel, PartyEventView, EventsCollection, JST){
	'use strict'

	var EventsCollectionView = Backbone.View.extend({

		template: JST['app/scripts/templates/eventsCollection.ejs'],

		el: '.elements',

		//el: '.content',

		initialize: function() {
			_(this).bindAll('add', 'remove');

			this._eventsViews = [];

			var that = this;

			this.collection.fetch({
				success: function(data) {
					data.each(function(d) {
						that.add(d);
					});
					that.render();
				},
				error: function() {
					console.log('collection could not be retrieve');
				}
			});

			this.collection.each(this.add);

			this.collection.bind('add', this.add);
			this.collection.bind('close', this.close);
		},

		add: function(PartyEventModel) {

			var ev = new PartyEventView({
				tagName: 'li',
				model: PartyEventModel
			});

			this._eventsViews.push(ev);

			//if (this._rendered) {
			//$(this.el).append(ev.render().el);
			//}
		},

		close: function(PartyEventModel) {

			var viewToRemove = _(this._eventsViews).select(function(cv) { return cv.model === model; })[0];
			this._eventsViews = _(this._eventsViews).without(viewToRemove);

			if (this._rendered) {
				$(viewToRemove.el).remove();
			}
		},

		render: function() {

			this._rendered = true;

			console.log(this.collection);
			$(this.el).empty();
			var that = this;
			_(this._eventsViews).each(function(ev) {
				$(that.el).append(ev.render().el);
				//this.$('ul.events').append(ev.render().el);
			});

			//return this;
		}
	});

	return EventsCollectionView;
});