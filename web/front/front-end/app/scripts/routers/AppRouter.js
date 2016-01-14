define(function(require, exports, module){
    var _ = require('underscore');
    var $ = require('jquery');
    var Backbone = require('backbone');
    var Parse = require('parse');
    var EventsCollection = require('collections/EventsCollection');
    var PartyEventModel = require('models/MyPartyEvent');
    var AppView = require('views/App');
    var PartyEventView = require('views/PartyEvent');
    var EventsCollectionView = require('views/EventsCollectionView');
    var HomeView = require('views/Home');
    var LoginView = require('views/Login');

    var AppRouter = Parse.Router.extend({
        routes: {
        "": "home",
        "login": "login",
        "logout": "logout",
        "events": "events",
        "signup": "signup"
        },

        home: function() {
            console.log('hello main');
        },

        login: function() {
            console.log('hello login');
        },

        logout: function() {
            console.log('hello logout');
            Parse.User.logOut();
        },

        events: function() {
            console.log('hello events');
        },

        signup: function() {
            console.log('hello signup');
        }

        });
    
    return AppRouter;
});

/*    var AppRouter = Parse.Router.extend({
        initialize: function(){
            console.log('initialized router');
        },
        routes: {
            '': 'home',
            'news':'news',
            'events': 'eventsfeed',
            'event/:id': 'editEvent',
            'contact': 'contact',
            'login': 'login'
        },
        home: function() {
            var partyevents = new PartyEventsCollection();

            partyevents.fetch({
                success: function(data) {
                    var loginView = new LoginView({
                        collections: data
                    });
                    $('content').html(loginView.render().el);
                },
                error: function(error)      {
                    console.log(error.message);
                }
            });
        console.log('hello main');
        },
        news: function(){},
        eventsfeed: function(){
            console.log('hello events');
        },
        editEvent: function(){},
        contact: function(){},
        login: function() {

            var loginView = new LoginView();
            console.log('Hello login');
        }
    });
    return AppRouter;
});
*/