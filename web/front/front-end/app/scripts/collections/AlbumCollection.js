define([
    'underscore',
    'backbone'
], function(_, Backbone) {

	var AlbumCollection = Backbone.Collection.extend({
        
        url: 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=d95c2f660e276021fac7f4448a22288b&photoset_id=72157657736819659&user_id=126031684%40N07',
      
        parse: function (data) {
            
            var parsed = [];
            
            $(data).find('photo').each(function (index) {
            
                var photoId = $(this).find('id').text();
                var secret = $(this).find('secret').text();
                var server = $(this).find('server').text();
                var farm = $(this).find('farm').text();
                parsed.push({photoId: photoId, secret: secret, server: server, farm: farm});
        
            });

        console.log(parsed);

        return parsed;
    },

    fetch: function (options) {
        options = options || {};
        options.dataType = "xml";
        return Backbone.Collection.prototype.fetch.call(this, options);
    }
    });

    return AlbumCollection;
});