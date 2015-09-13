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
            'submit form.signup-form': 'signUp'
        },

        el: '.content',

        initialize: function(){
            _.bindAll(this, 'logIn', 'signUp');
            this.render();
        },

        logIn: function(e){
            var self = this;

            var username = this.$('#login-username').val();
            var password = this.$('#login-password').val();

            Parse.User.logIn(username, password, {
                success: function(user) {
                    console.log('yes, I got it');
                },
                error: function(user, error){
                    self.$('.login-form .error').html('Invalid username or password. Please try again.').show();
                    self.$('.login-form button').removeAttr('disabled');
                }
            });
            return false;
        },

        signUp: function(e){
            var self = this;
            var username = this.$('#signup-username').val();
            var password = this.$('#signup-password').val();

            Parse.User.signUp(username, password, {
                ACL: new Parse.ACL()
            }, {
                success: function(user){
                    console.log('yes, I got it user created');
                },
                error: function(user, error){
                    self.$('.signup-form .error').html(error.message).show();
                    self.$('.signup-form button').removeAttr('disabled');
                }
            });
            this.$('.signup-form button').attr('disabled', 'disabled');

            return false;
        },

        render: function(){
            this.$el.html(this.template());
            this.delegateEvents();
        }
    });

    return LoginView;
});
