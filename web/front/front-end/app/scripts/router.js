define(function(require, exports, module){
    var _ = require('underscore');
    var $ = require('jquery');
    var Backbone = require('backbone');
    var Parse = require('parse');
    var EventsCollection = require('collections/EventsCollection');
    var PartyEventModel = require('models/MyPartyEvent');
    var PartyEventView = require('views/PartyEvents');
    var EventsCollectionView = require('views/EventsCollectionView');
    var HomeView = require('views/Home');
    var LoginView = require('views/Login');
    var PaymentView = require('views/PaymentView');


    module.exports = Backbone.Router.extend({

        initialize: function() {
        },

        routes: {
        "": "home",
        "login": "login",
        "logout": "logout",
        "events": "events",
        "payment": "payment",
        "signup": "signup"
        },

        home: function() {

            if (!Parse.User.current())
            {
                this.navigate('#login', {trigger : true});
            }
            else
            {
                var homeView = new HomeView;
                this.loadView(homeView);
            }
        },

        login: function() {
            var logView = new LoginView();
            //logView.render();
            this.loadView(logView);
        },

        logout: function() {
            Parse.User.logOut();
            this.login();
        },

        events: function() {
            console.log('hello events');
            this.navigate('#events', {trigger : true});
            var evView = new EventsCollectionView;
            //evView.render();
            this.loadView(evView);
        },

        payment: function() {
            console.log('hello payment');
            this.navigate('#payment', {trigger : true});
            var payView = new PaymentView;
            //payView.render();
            this.loadView(payView);
        },

        signup: function() {
            console.log('hello signup');
        },

        loadView : function(view) {
        this.view && (view.close ? view.close() : view.remove());
        console.log('erase shit');
        view.render();
        }

    });
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