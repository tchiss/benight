require(['config'], function () {
    require(['app', 'router'], function(app, Router) {

        app.router = new Router();

        app.router.bind("all", function(route, router) {

        });

        Backbone.history.start();
    });
});