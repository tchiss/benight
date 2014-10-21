define(["backbone"],function(){
	var e=Backbone.View.extend({
		initialize:function(){
			console.log("Wahoo!");
		}
	});
	return e;
});

/*define(["../routers"], function(Router){
	var initialize: function(){
		Router.initialize();
	}

	return {
		initialize: initialize
	};
});*/