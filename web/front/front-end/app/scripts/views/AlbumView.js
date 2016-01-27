define(['jquery',
    'underscore',
    'backbone',
    'templates',
    'models/AlbumModel',
    'collections/AlbumCollection',
    'views/ResaCreateView',
    'views/PaymentView',
    'views/ReservationView'
    ], function($, _, Backbone, JST, AlbumCollection){
        'use strict'

        var AlbumView = Backbone.View.extend({

            el: '.elements',

            initialize: function(AlbumId) {

                var albumColl = new AlbumCollection();

                albumColl.url = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=d95c2f660e276021fac7f4448a22288b&photoset_id=' + AlbumId.albumId + '&user_id=' + AlbumId.userId;

                this.collection = albumColl;

                var that = this;

                _.bindAll(this, 'render');
                var caca=albumColl.fetch({});
                //console.log(albumColl.parse(caca));
            },

            render: function() {

                $(this.el).append("<ul></ul>");
                
                for (var i = 0; i < this.collection.length; i++) 
                {
                    $('ul', this.el).append("<li>" + i + this.collection.models[i].get("description") + "</li>");
                }
            }
        });

    return AlbumView;

});