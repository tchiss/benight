define([
	'backbone',
	'parse',
	'models/MyPartyEvent'
], function(Backbone, Parse, PartyEventModel) {

  var EventsCollection = Parse.Collection.extend({
    model: PartyEventModel,
  });

  return EventsCollection;
});