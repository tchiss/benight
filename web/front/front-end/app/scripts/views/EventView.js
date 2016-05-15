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

    var EventSoloView = Backbone.View.extend({

            //template: JST['app/scripts/templates/PartyEvents.ejs'],

            template: JST['app/scripts/templates/event_solo.ejs'],

            //tagName: 'li',

            el: '.elements',

            events: {
              "click .log-out": "logOut",
              "click .news-section": "news",
              "click .home-section": "home",
              "click .reserve": "reserver"
              //"click .events-section": "eventsSection"
          },


          initialize: function(){

                _.bindAll(this, 'render', 'logOut', 'home', 'news');
                this.model.bind('change', this.render);
                this.model.bind('destroy', this.remove);
                this.render();

            },

            logOut: function(e) {
                Parse.User.logOut();
                new LoginView();
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

            reserver: function(e) {
                console.log("je réserve!");
                var resaObject = new ReservationModel();
                resaObject.set("User", Parse.User.current());
                resaObject.set("Event", this.model);
                resaObject.save(null, {
                    success: function(resaObject) {
                        // Execute any logic that should take place after the object is saved.
                        console.log('New reservation made for the Event: ' + resaObject.id);
                    },
                    error: function(resaObject, error) {
                        // Execute any logic that should take place if the save fails.
                        // error is a Parse.Error with an error code and message.
                        alert('Failed to create new object, with error code: (resa)' + error.message);
                    }
                });

                var ticketObject = new TicketModel();
                ticketObject.set("Date", this.model.get('date'));
                ticketObject.set("EventName", this.model.get('name'));
                ticketObject.set("EventPlace",this.model.get('author'));
                ticketObject.set("User", Parse.User.current());
                ticketObject.save(null, {
                    success: function(ticketObject) {
                        console.log('New ticket created with the ID : ' + ticketObject.id);
                        resaObject.set("Tickets", ticketObject);
                        resaObject.save(null, {
                            success: function(resaObject) {
                                console.log('Reservation complete!');
                                ticketObject.set("Reservation", resaObject);
                                ticketObject.save(null, {
                                    success: function(ticketObject){
                                        console.log('Tickets complete!');
                                        new ResaView(ticketObject);
                                    },
                                    error: function(ticketObject, error){
                                        console.log('error save ticket : ' + error.message);
                                    }
                                });
                            },
                            error: function(resaObject, error){
                                console.log('error save resa : ' + error.message);
                            }
                        });
                        alert('Reservation for the event \"' + ticketObject.get('EventName') + '\" confirmed!');
                    },
                    error: function(ticketObject, error) {
                        alert('Failed to create new object, with error code (ticket): ' + error.message); 
                    }
                });
            },

            close: function () {
                $(this.el).empty();
            },

            render: function () {

                this.$el.html(this.template(this.model.toJSON()));

                if (typeof this.model.get("Album") === "undefined")
                {
                    document.getElementById('album').href = '';
                    document.getElementById("button_photo").innerHTML = "No Pictures!"
                }
                else if (this.model.get("Album").id)
                {

                    var albumModel = Parse.Object.extend('PhotoAlbum');

                    var query = new Parse.Query(albumModel); 
                    query.get(this.model.get("Album").id, {
                        success: function(albumModel) {

                            var FlickrAlbumId = albumModel.get("FlickrAlbumId");
                            var FlickrUserId = albumModel.get("FlickrUserId");

                            var url = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=d95c2f660e276021fac7f4448a22288b&photoset_id='+FlickrAlbumId+'&user_id='+FlickrUserId;//'https://www.flickr.com/photos/'+FlickrUserId+'/sets/'+FlickrAlbumId

                            document.getElementById("album").href = '#gallery/'+FlickrAlbumId+'/'+FlickrUserId;

                        },
                        error: function(albumModel, error) {
                            console.log('damn');
                        }
                    });
                }
                //this.delegateEvents();
                //this.input = this.$('.edit');
                return this;
            },

      });

    return EventSoloView;
});