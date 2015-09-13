/*global require*/
'use strict';

require.config({
    shim: {
        underscore: {
            exports: '_'
        },
        backbone: {
            deps: [
                'underscore',
                'jquery'
            ],
            exports: 'Backbone'
        },
        bootstrap: {
            deps: ['jquery'],
            exports: 'jquery'
        },
        parse: {
            exports: 'Parse'
        }
    },
    paths: {
        jquery: '../bower_components/jquery/jquery',
        backbone: '../bower_components/backbone/backbone',
        underscore: '../bower_components/underscore/underscore',
        bootstrap: 'vendor/bootstrap',
        parse: 'vendor/parse-1.3.3.min'
    }
});

require(['parse'], function(Parse) {
    Parse.initialize("KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "d5Pye5IKCldho2Vtjdyw0PM7ySaSDX4pxOR2atNM");
});

require([
    'backbone',
    'parse',
    'routers/AppRouter',
    'models/MyPartyEvent',
    'views/App',
    'views/Events',
    'views/Login'
], function (Backbone, Parse, PartyEventModel, AppRouter, AppView, EventsView, LoginView) {


    new AppView();
    //new AppRouter();

    Backbone.history.start();
    console.log('Hello from Backbone!');
});
