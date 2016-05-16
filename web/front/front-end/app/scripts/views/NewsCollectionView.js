define(['jquery',
        'underscore',
        'backbone',
        'models/NewsModel',
        'views/NewsView',
        'collections/NewsCollection',
        'templates'
], function($, _, Backbone, NewsModel, NewsView, NewsCollection, JST){
	'use strict'

	var newsColl = new NewsCollection();

	var NewsCollectionView = Backbone.View.extend({

		template: JST['app/scripts/templates/newsCollection.ejs'],

		collection: newsColl,

		el: '.elements',

		//el: '.content',

		initialize: function() {
			_(this).bindAll('add', 'remove');

			this._newsViews = [];

			var that = this;

			this.collection.fetch({
				success: function(data) {
					data.each(function(d) {
						that.add(d);
						console.log("coucou");
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

		add: function(NewsModel) {

			var nv = new NewsView({
				tagName: 'li',
				model: NewsModel
			});

			this._newsViews.push(nv);

			//if (this._rendered) {
			//$(this.el).append(ev.render().el);
			//}
		},

		close: function(NewsModel) {

			var viewToRemove = _(this._newsViews).select(function(cv) { return cv.model === model; })[0];
			this._newsViews = _(this._newsViews).without(viewToRemove);

			if (this._rendered) {
				$(viewToRemove.el).remove();
			}
		},

		render: function() {

			this._rendered = true;

			$(this.el).empty();
			var that = this;
			_(this._newsViews).each(function(nv) {
				$(that.el).append(nv.render().el);
				//this.$('ul.events').append(ev.render().el);
			});

			return this;
		}
	});

	return NewsCollectionView;
});