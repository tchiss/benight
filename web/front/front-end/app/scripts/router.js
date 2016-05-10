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
    var EventSoloView = require('views/EventView');
    var AlbumView = require('views/AlbumView');
    var NewsCollection = require('collections/NewsCollection');
    var NewsModel = require('models/NewsModel');
    var NewsView = require('views/NewsView');
    var NewsCollectionView = require('views/NewsCollectionView');
    var AccountView = require('views/Account');
    //var NewsSoloView = require('views/NewsSoloView');


    module.exports = Backbone.Router.extend({

        initialize: function() {
        },

        routes: {
        "": "home",
        "login": "login",
        "logout": "logout",
        "events": "events",
        "event/:eventID": "event",
        "payment/:eventID": "payment",
        "album/:albumID": "album",
        "news": "news",
        "account": "account",
        //"news/:newsID": "news",
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
            this.navigate('', {trigger: true});
        },

        events: function() {
            console.log('hello events');
            this.navigate('#events', {trigger : true});
            var evView = new EventsCollectionView;
            //evView.render();
            this.loadView(evView);
        },

        event: function(eventID) {

            var soloModel = Parse.Object.extend('Event');

            var query = new Parse.Query(soloModel);
            query.get(eventID, {
                success: function(soloModel) {
                    var EventView = new EventSoloView({model: soloModel});
                },
                error: function(soloModel, error) {
                    console.log('damn');
                }
            });
        },

        news: function() {
            console.log('hello news');
            this.navigate('#news', {trigger : true});
            var nvView = new NewsCollectionView;
            //evView.render();
            this.loadView(nvView);
        },

        account: function() {
            console.log('hello account');
            this.navigate('#account', {trigger: true});
            var accView = new AccountView();
            this.loadView(accView);
        },

        /*new: function(newsID) {

            var soloModel = Parse.Object.extend('News');

            var query = new Parse.Query(soloModel);
            query.get(eventID, {
                success: function(soloModel) {
                    var NewsView = new newsSoloView({model: soloModel});
                },
                error: function(soloModel, error) {
                    console.log('damn');
                }
            });
        },*/

        payment: function(eventID) {

            var soloModel = Parse.Object.extend('Event');

            var query = new Parse.Query(soloModel);
            query.get(eventID, {
                success: function(soloModel) {

                    var price = soloModel.get("price");

                    var payView = new PaymentView({amount: price});
                },
                error: function(soloModel, error) {
                    console.log('damn');
                }
            });
        },

        album: function(albumID) {

            var albumModel = Parse.Object.extend('PhotoAlbum');

            var query = new Parse.Query(albumModel); 
            query.get(albumID, {
                success: function(albumModel) {

                    var FlickrAlbumId = albumModel.get("FlickrAlbumId");
                    var FlickrUserId = albumModel.get("FlickrUserId");

                    var albumView = new AlbumView({albumId: FlickrAlbumId, userId: FlickrUserId});
                },
                error: function(albumModel, error) {
                    console.log('damn');
                }
            });
        },

        signup: function() {
            console.log('hello signup');
        },

        loadView : function(view) {
        this.view && (view.close ? view.close() : view.remove());
        //console.log('erase shit');
        view.render();
        }

    });
});