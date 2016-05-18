require.config({
    paths: {
        'jquery': '../bower_components/jquery/jquery',
        'backbone': '../bower_components/backbone/backbone',
        'underscore': '../bower_components/underscore/underscore',
        'three': '../../Render3D/include/js/three.min',
        'bootstrap': 'vendor/bootstrap',
        'node-twitter-api': '../../nodes_modules/node-twitter-api/twitter',
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

        window.fbAsyncInit = function() {
        Parse.FacebookUtils.init({ // this line replaces FB.init({
          appId      : '{603572813098360}', // Facebook App ID
          status     : true,  // check Facebook Login status
          cookie     : true,  // enable cookies to allow Parse to access the session
          xfbml      : true,  // initialize Facebook social plugins on the page
          version    : 'v2.2' // point to the latest Facebook Graph API version
        });

            // Run code after the Facebook SDK is loaded.
        };

          (function(d, s, id){
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    });
});

