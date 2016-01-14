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
                ACL: new Parse.ACL()
            }, {
                success: function(user){
                    console.log('yes, I got it user created');
                    alert("Vous vous êtes bien enregistré chez Benight! Veuillez maintenant vous connecter avec le username et mot de passe que vous avez créés.");
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

        render: function(){
            this.$el.html(this.template());
            return this;
        }
    });

    return LoginView;
});
