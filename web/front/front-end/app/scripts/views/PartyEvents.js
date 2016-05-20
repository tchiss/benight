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

                    //console.log(this.model.attributes.Flyer._url);

                    if (!this.model.attributes.author)
                        this.model.attributes.author = '';
                    if (!this.model.attributes.Description)
                        this.model.attributes.Description = 'Etrange...il n\'y a aucune description pour cette soirée!';

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

                var str = this.model.attributes.Flyer._url;

                var link = 'http://' + str.substr(7);

                console.log(link);

                this.$el.html(this.template(this.model.toJSON()));
                //document.getElementById('pic').src = link;
                //this.delegateEvents();
                //this.input = this.$('.edit');
                return this;
            },
    });

    return PartyEventView;
});
