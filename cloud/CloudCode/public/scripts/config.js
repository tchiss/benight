'use strict'

require.config({
	shim: {
		underscore: {
            deps: ['jquery'],
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
        jquery: 'libs/jquery/dist/jquery.min',
        backbone: 'libs/backbone/backbone-min',
        underscore: 'libs/underscore/underscore-min',
        bootstrap: 'libs/bootstrap-sass/bootstrap/bootstrap.min',
        parse: 'libs/parse/parse.min' 
    }
});

require(['parse'], function(Parse) {
    Parse.initialize("KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "d5Pye5IKCldho2Vtjdyw0PM7ySaSDX4pxOR2atNM");
});

require([
    'backbone',
    'parse',
    'router'
], function (Backbone, Parse, Router) {

    var app = new Router();
    Backbone.history.start();
    console.log('Hello from Backbone Benight!');
});


