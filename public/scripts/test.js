require('supertest');
/*define(['backbone', 'underscore'], function($, Backbone, _){
});*/

describe("App", function() {
	  return describe("#initialize", function() {
	    return it("starts Backbone.history", function() {
	      Backbone.history.started = null;
	      Backbone.history.stop();
	      sinon.spy(Backbone.history, "start");
	      App.initialize({});
	      expect(Backbone.history.start).toHaveBeenCalled();
	      return Backbone.history.start.restore();
	    });
	  });
	});