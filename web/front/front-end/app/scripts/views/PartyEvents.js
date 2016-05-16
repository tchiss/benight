define(['jquery',
    'underscore',
    'backbone',
    'templates',
    'models/MyPartyEvent',
    'models/ReservationModel',
    'models/TicketModel',
    'models/CodeModel',
    'collections/EventsCollection',
    'views/ResaCreateView',
    'views/PaymentView',
    'views/ReservationView'
    ], function($, _, Backbone, JST, PartyEventModel, ReservationModel, TicketModel, CodeModel, EventsCollection, ResaView, PaymentView, ReservationView){
        'use strict'

    var PartyEventView = Backbone.View.extend({

            //template: JST['app/scripts/templates/PartyEvents.ejs'],

            template: JST['app/scripts/templates/event.ejs'],

            model: PartyEventModel,

            tagName: 'li',

            //el: '.elements',

            events: {
              "click .log-out": "logOut",
              "click .news-section": "news",
              "click .home-section": "home",
              //"click .reserve": "reserver"
              //"click .events-section": "eventsSection"
          },

            //calssName: 'list-group-item',

                // The DOM events specific to an item.

                initialize: function(){

                    _.bindAll(this, 'render', 'logOut', 'home', 'news');
                    this.model.bind('change', this.render);
                    this.model.bind('destroy', this.remove);
                    this.render();
                },

                logOut: function(e) {
                  Parse.User.logOut();
                  Backbone.history.loadUrl('');
                  this.undelegateEvents();
                  delete this;
              },

              home: function(e) {
                console.log("i'm home");
            },

            news: function(e)  {
                console.log("what's new");
                new NewsView();
                this.undelegateEvents();
                delete this;
            },

            close: function () {
                $(this.el).empty();
            },

            render: function () {
                this.$el.html(this.template(this.model.toJSON()));
                //this.delegateEvents();
                //this.input = this.$('.edit');
                return this;
            },
    });

    return PartyEventView;
});
