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
    var NewsCollection = require('collections/NewsCollection');
    var NewsModel = require('models/NewsModel');
    var NewsView = require('views/NewsView');
    var NewsCollectionView = require('views/NewsCollectionView');
    var AccountView = require('views/Account');
    var AboutView = require('views/About');
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
        "about": "about",
        "gallery/:FlickrAlbumId/:FlickrUserId": "gallery",
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
               /* this.navigate('#events', {trigger : true});
            var evView = new EventsCollectionView;
            //evView.render();
            this.loadView(evView);*/
                $('.navbar').show();
                $('.wrp').hide();
                var homeView = new HomeView;
                this.loadView(homeView);
            }
        },

        login: function() {
            $('.wrp').hide();
            $('.navbar').hide();
            var logView = new LoginView();
            //logView.render();
            this.loadView(logView);
        },

        logout: function() {
            Parse.User.logOut();
            location.reload();
            this.navigate('#login', {trigger: true});
        },

        events: function() {
            $('.wrp').hide();
            console.log('hello events');
            this.navigate('#events', {trigger : true});
            var evView = new EventsCollectionView;
            //evView.render();
            this.loadView(evView);
        },

        event: function(eventID) {

            $('.wrp').hide();

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
            $('.wrp').hide();
            console.log('hello news');
            this.navigate('#news', {trigger : true});
            var nvView = new NewsCollectionView;
            //evView.render();
            this.loadView(nvView);
        },

        account: function() {
            $('.wrp').hide();
            console.log('hello account');
            this.navigate('#account', {trigger: true});
            var accView = new AccountView();
            this.loadView(accView);
        },

        about: function() {
            $('.wrp').hide();
            console.log('hello about');
            this.navigate('#about', {trigger: true});
            var aboutView = new AboutView();
            this.loadView(aboutView);
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

        gallery: function(FlickrAlbumId, FlickrUserId) {

            if (!Parse.User.current())
            {
                this.navigate('#login', {trigger : true});
            }
            else
            {
            
                $('.wrp').show();

                console.log(FlickrAlbumId);

                var Item = Backbone.Model.extend({});
                var item = new Item();

                var ItemsCollection = Backbone.Collection.extend({
                    model: Item
                });

                var ItemView = Backbone.View.extend({
                    className: "list__item",

                    tmpl: "#item",

                    render: function(){
                        var tmpl = _.template($(this.tmpl).html());

                        document.getElementById("pic").src = "http://farm" + this.model.attributes.farm + ".static.flickr.com/" + this.model.attributes.server + "/" + this.model.attributes.id + "_" + this.model.attributes.secret + "_" + "s.jpg";
                        document.getElementById("link").href = "http://www.flickr.com/photos/" + FlickrUserId + "/" + this.model.attributes.id + "/";

                        this.$el.html(tmpl(this.model.toJSON()));

                        return this;
                    }
                });

                var ItemsView = Backbone.View.extend({
                    initialize: function(){
                        console.log(this.collection);
                    },

                    className: "list",

                    render: function(){
                        this.collection.each(function(item){
                            var itemView = new ItemView({model: item});

                            this.$el.append(itemView.render().el);
                        }, this);

                        return this;
                    }
                });

                /*var albumModel = Parse.Object.extend('PhotoAlbum');

                var query = new Parse.Query(albumModel);
                console.log(query); 
                query.get(id, {
                    success: function(albumModel) {

                        var FlickrAlbumId = albumModel.get("FlickrAlbumId");
                        var FlickrUserId = albumModel.get("FlickrUserId");

                        var url = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=d95c2f660e276021fac7f4448a22288b&photoset_id='+FlickrAlbumId+'&user_id='+FlickrUserId

                        },
                        error: function(albumModel, error) {
                            console.log('damn');
                        }
                    });*/
                
                var link = 'https://api.flickr.com/services/rest/?format=json&method=flickr.photosets.getPhotos&api_key=d95c2f660e276021fac7f4448a22288b&photoset_id='+FlickrAlbumId+'&user_id='+FlickrUserId+'&jsoncallback=?'; //"http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?";

                console.log(link);

                $.getJSON(link, 
                    function(data){
                        var itemsCollection = new ItemsCollection(data.photoset.photo);
                        var itemsView = new ItemsView({collection: itemsCollection});

                        $(".wrp").html(itemsView.render().el);
                    }
                );

            }

            /*var link = "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?";

            $.getJSON(link,
                {
                    tags: "mount rainier",
                    tagmode: "any",
                    format: "json"
                }, 
                function(data){
                    var PhotoCollection = new PhotoCollection(data.items);
                    var PhotoCollectionView = new PhotoCollectionView({collection: PhotoCollection});

        //$(".wrp").html(itemsView.render().el);
                });*/
        },

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