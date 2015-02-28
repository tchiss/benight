define(['backbone', 'models/BenightEvents'], function(Backbone, EventsModel) {

  var EventsCollection = Backbone.Collection.extend({
    model: EventsModel,
    url: '/events'
  });

  return EventsCollection;
});