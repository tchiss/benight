
define([
    'jquery',
    'underscore',
    'backbone',
    'parse',
    'models/MyPartyEvent',
    'views/PartyEvents',
    'views/Login'
], function($, _, Backbone, Parse, PartyEventModel, PartyEventView, LoginView) {
    'use strict';

    var currentUser = Parse.User.current();

    var myModel = new PartyEventModel();

    var AppView = Backbone.View.extend({
        el: '#faithgroup-admin',

        initialize: function(){
            this.render();
        },

        render: function(){
            console.log('AppView');
            if(currentUser) {
                var eventView = new PartyEventView({
                    model: myModel
                });
            } else {
                new LoginView();
            }
        }
    });

    return AppView;
});
