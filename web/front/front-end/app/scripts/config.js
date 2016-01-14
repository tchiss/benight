require.config({
    paths: {
        'jquery': '../bower_components/jquery/jquery',
        'backbone': '../bower_components/backbone/backbone',
        'underscore': '../bower_components/underscore/underscore',
        'three': '../../Render3D/include/js/three.min',
        'bootstrap': 'vendor/bootstrap',
        'parse': 'vendor/parse-1.3.3.min'
    },
    
    shim: {
        underscore: {
            exports: '_'
        },
        backbone: {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        bootstrap: {
            deps: ['jquery']
        },
        parse: {
            exports: 'Parse'
        }
    }
});

require(['parse'], function(Parse) {
        Parse.initialize("KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "d5Pye5IKCldho2Vtjdyw0PM7ySaSDX4pxOR2atNM");
    });

