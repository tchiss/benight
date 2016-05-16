define(['jquery',
    'underscore',
    'backbone',
    'templates',
    'models/NewsModel',
    'collections/NewsCollection',
    'views/PartyEvents',
    'views/PaymentView',
    'views/ReservationView'
    ], function($, _, Backbone, JST, NewsModel, NewsCollection, PartyEventView){
        'use strict'

    var NewsView = Backbone.View.extend({

            //template: JST['app/scripts/templates/PartyEvents.ejs'],

            template: JST['app/scripts/templates/news.ejs'],

            model: NewsModel,

            tagName: 'li',

            //el: '.content',

            /*events: {
              "click .log-out": "logOut",
              "click .events-section": "events",
              "click .home-section": "home",
              //"click .reserve": "reserver"
              //"click .events-section": "eventsSection"
          },*/

            //calssName: 'list-group-item',

                // The DOM events specific to an item.

                initialize: function(){

                    _.bindAll(this, 'render');
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

            /*events: function(e)  {
                console.log("event list");
                new PartyEventView();
                this.undelegateEvents();
                delete this;
            },*/

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

    return NewsView;
});
