
define([
    'jquery',
    'underscore',
    'backbone',
    'parse',
    'views/PartyEvents',
    'views/Login'
], function($, _, Backbone, Parse, PartyEvents, LoginView) {
    'use strict';

    var currentUser = Parse.User.current();

    var AppView = Backbone.View.extend({
        el: '#faithgroup-admin',

        initialize: function(){
            this.render();
        },

        render: function(){
            console.log('AppView');
            if(currentUser) {
                console.log('negro');
                new PartyEvents();
            } else {
                new LoginView();
            }
        }
    });

    return AppView;
});
