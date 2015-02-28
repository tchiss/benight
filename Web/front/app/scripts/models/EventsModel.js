define(['backbone'], function(Backbone) {

  var EventsModel = Backbone.Model.extend({
    urlRoot: '/events',
    idAttribute: 'eventsId'
  });

  return EventsModel;
});
