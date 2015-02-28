define(['jquery',
        'underscore',
        'backbone',
        'models/MyPartyEvent',
        'templates'
], function($, _, Backbone, JST){
    'use strict'

	var EventsView = Backbone.View.extend({

	template: JST['app/scripts/templates/PartyEvents.ejs'],

    tagName: 'li',

    calssName: 'list-group-item',

		initialize: function()
		{
			_.bindAll(this, 'render', 'close', 'remove');

		},
		render: function()
		{
			this.$el.html(this.template(this.model.toJSON()));
			this.model.bind('change', this.render);
			this.model.bind('destroy', this.remove);
			this.input = this.$('.edit');
			return this;
		},
		events:
		{
			'dbclick label' : 'edit',
			'keypress .edit' : 'updateOnEnter',
			'blur .edit' : 'close',
			'click .toggle': 'toggleCompleted',
			'click .destroy': 'destroy'
		},
		edit: function()
		{
			this.$el.addClass('editing');
			this.input.focus();
		},
		close: function()
		{
			var value = this.input.val().trim();
			if(value)
			{
				this.model.save({title: value})
			}
			this.$el.removeClass('editing');
		},
		updateOnEnter: function(e)
		{
			if(e.which == 13)
			{
				this.close();
			}
		},
		toggleCompleted: function()
		{
			this.model.toggle();
		},
		destroy: function()
		{
			this.model.destroy();
		}
	});

	return EventsView;
});