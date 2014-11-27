define(function(require, exports, module) {
  "use strict";

  // External dependencies.
  var Backbone = require("backbone");

  // Defining the application router.
  var Router = Backbone.Router.extend({
    routes: {
      "": "index",
      "/events": "listEvents"
    },

    index: function() {
      console.log("Welcome to your / route lol Alain.");
    },
    listEvents: function(){
      console.log("Welcome to your /events.");
    }
  });

  module.exports = Router;
});
