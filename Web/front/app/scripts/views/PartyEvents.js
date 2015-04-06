define(['jquery',
        'underscore',
        'backbone',
        'templates',
        'collections/EventsCollection'
], function($, _, Backbone, JST, EventsCollection){
    'use strict'

/*var PartyCollection = new EventsCollection();

    PartyCollection.fetch({
        success: function(PartyCollection) {
            PartyCollection.each(function(PartyEventModel) {
                console.warn(PartyEventModel);
            });
        },
        error: function() {
            console.log('collection could not be retrieve');
        }
    });*/

var PartyEventView = Backbone.View.extend({

    template: JST['app/scripts/templates/PartyEvents.ejs'],

    tagName: 'li',

    calssName: 'list-group-item',

        // The DOM events specific to an item.

    initialize: function(){
        _.bindAll(this, 'render', 'close', 'remove');
        this.model.bind('change', this.render);
        this.model.bind('destroy', this.remove);
        var PartyCollection = new EventsCollection();
        PartyCollection.fetch({
            success: function(PartyCollection) {
                PartyCollection.each(function(PartyEventModel) {
                    console.log(PartyEventModel.get("name"));
                });
            },
            error: function() {
                console.log('collection could not be retrieve');
            }
        });
        this.render();
    },

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));
        this.input = this.$('.edit');
        return this;
    },

    events: {
        'click .toggle': 'toggleDone',
        'dblclick label.partyevent-content': 'edit',
        'click .partyevent-destroy': 'clear',
        'keypress .edit': 'updateOnEnter',
        'blur .edit': 'close'
    },

    toggleDone: function(){
        this.model.toggle();
    },

    edit: function(){
        $(this.el).addClass('editing');
        this.input.focus();
    },

    close: function() {
        this.model.save({
            name: this.input.val()
        });
        $(this.el).removeClass('editing');
    },

    clear: function(){
        this.model.destroy();
    }
  });

  //Benight.Views.PartyeventsView = PartyeventsView;
  return PartyEventView;
});
