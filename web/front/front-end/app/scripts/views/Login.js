/* Login Page */

define(['jquery',
        'underscore',
        'backbone',
        'parse',
        'templates'
], function($, _, Backbone, Parse, JST) {
    'use strict';

    var LoginView = Backbone.View.extend({

        template: JST['app/scripts/templates/login.ejs'],

        events: {
            'submit form.login-form': 'logIn',
            'submit form.signup-form': 'signUp',
            'click #fb_content': 'facebookLogin'
        },

        el: '.elements',

        initialize: function(){
            _.bindAll(this, 'render', 'logIn', 'signUp');
            this.render();
        },

        logIn: function(e){

            e.preventDefault();
            var self = this;

            var username = this.$('#login-username').val();
            var password = this.$('#login-password').val();

            console.log('login function');

            Parse.User.logIn(username, password, {
                success: function(user) {
                    console.log('yes, I got it');
                    self.undelegateEvents();
                    Backbone.history.navigate('/', {trigger : true});
                },
                error: function(user, error){
                    self.$('.login-form .error').html('Invalid username or password. Please try again.').show();
                    self.$('.login-form button').removeAttr('disabled');
                }
            });
            //return false;
        },

        signUp: function(e){

            var self = this;
            var username = this.$('#signup-username').val();
            var password = this.$('#signup-password').val();
            var email = this.$('#signup-email').val();
            var user = new Parse.User();

            user.set("username", username);
            user.set("password", password);
            user.set("email", email);

            user.signUp(null, {
                success: function(user){
                    console.log('yes, I got it user created');
                    alert("Vous vous êtes bien enregistré chez Benight! Veuillez maintenant vous connecter avec le Nom d'Utilisateur et Mot de Passe que vous avez créés.");
                },
                error: function(user, error){
                    self.$('.signup-form .error').html(error.message).show();
                    self.$('.signup-form button').removeAttr('disabled');
                }
            });
            this.$('.signup-form button').attr('disabled', 'disabled');

            e.preventDefault();

            //return false;
        },

        facebookLogin: function(e) {

            Parse.FacebookUtils.init({ // this line replaces FB.init({
                appId      : '603572813098360', // Facebook App ID
                status     : true,  // check Facebook Login status
                cookie     : true,  // enable cookies to allow Parse to access the session
                xfbml      : true,  // initialize Facebook social plugins on the page
                version    : 'v2.2' // point to the latest Facebook Graph API version
            });

            console.log('Facebook');

            Parse.FacebookUtils.logIn(null, {
                success: function(user) {
                    if (!user.existed()) {
                        alert("User signed up and logged in through facebook!");
                    } else {
                        alert("User logged in through facebook!!")
                    }
                },
                error: function(user, error) {
                    alert("User cancelled the Facebook login or did not fully authorize");
                }
            });
        },
/*
        twitterLogin: function(e) {

            console.log('COUILLE');

            var CONSUMER_KEY = 'LtvEpLPCAgZeoz53mU9LszLXP';
            var CONSUMER_SECRET = 'SfRKKRqmMlsP6DKBPse1ByXDa7q5ask7OeGEJNQNFZYsEm18ak';
            var CALLBACK = 'http://app.benight.cc/#events';            

            var logIn = function(req, onResponse) {
                var twitter = new twitterAPI({
                //set environment variables specific to Twitter application
                consumerKey: CONSUMER_KEY,
                consumerSecret: CONSUMER_SECRET,
                callback: CALLBACK
              });
        
              if(req.query.oauth_token && req.query.oauth_verifier) { //coming back from successful Twitter log in
                twitter.getAccessToken(req.session.requestToken, req.session.requestTokenSecret, req.query.oauth_verifier, function(error, accessToken, accessTokenSecret, results) {
                  if (error) {
                    onResponse.error("Error with retrieving access tokens: " + error);
                  } else {
                    //get credentials and store similarly to parse API.
                    twitter.verifyCredentials(accessToken, accessTokenSecret, function(error, data, response){
                      if (error) {
                        onResponse.error("Couldn't verifiy credentials: " + error);
                      } else {
                        //javascript sdk doesn't support logging in manually with authData.
                        //use REST API instead.
                        authData = {
                          'twitter': {
                            'id': data['id_str'],
                            'screen_name': data['screen_name'],
                            'consumer_key': CONSUMER_KEY,
                            'consumer_secret': CONSUMER_SECRET,
                            'auth_token': accessToken,
                            'auth_token_secret': accessTokenSecret
                          }
                        }
        
                        request.post({
                          headers: {'X-Parse-Application-Id': 'KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT', 'X-Parse-REST-API-Key': 'ZhCIBPq3Sa8MIAO5l6mLtpU2ksHrX1rs2eb8VhLr', 'Content-Type': 'application/json'},
                          url: 'https://api.parse.com/1/users',
                          json: {'authData': authData}
                        },
                          function (error, response, body) {
                            if (error) {
                              onResponse.error("Error authenticating with Parse: " + error);
                            } else {
                              onResponse.success(body);
                            }
                          }
                        );
                      }
                    });
                  }
                });
              } else {
                //display sign in forms.
                twitter.getRequestToken(function(error, requestToken, requestTokenSecret, results) {
                  if (error) {
                    onResponse.error("Error getting OAuth request tokens: " + error);
                  } else {
                    //store in session
                    req.session.requestToken = requestToken
                    req.session.requestTokenSecret = requestTokenSecret
                    authURL = "https://twitter.com/oauth/authenticate?oauth_token=" + requestToken
        
                    onResponse.auth_setup(authURL);
                  } 
                });
              }
            }

            var User = Parse.Object.extend('User');
            var userQuery = new Parse.Query(User);

            app.get('/', function(req, res) {
                currentUser = Parse.User.current();
                if (Parse.User.current() == null) {
                    //no user is signed in
                    twitter.logIn(req, {
                        auth_setup: function(authURL) {
                            //present log in page/modal.
                            console.log(authURL);
                        },
                        success: function(user) {
                            console.log(user);
                        },
                        error: function(error) {
                            console.log("Error logging in.\n" + error);
                        }
                    });
                }
            });
        },*/

        render: function(){
            this.$el.html(this.template());
            return this;
        }
    });
    return LoginView;
});
