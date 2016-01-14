define([
	'backbone',
	'parse',
	'models/ReservationModel'
], function(Backbone, Parse, ReservationModel) {

  var ReservationCollection = Parse.Collection.extend({
    model: ReservationModel,
  });

  return ReservationCollection;
});