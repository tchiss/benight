define([
	'backbone',
	'parse',
	'models/NewsModel'
], function(Backbone, Parse, NewsModel) {

  var NewsCollection = Parse.Collection.extend({
    model: NewsModel,
  });

  return NewsCollection;
});