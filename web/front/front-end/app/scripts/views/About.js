define(['jquery',
        'underscore',
        'backbone',
        'parse',
        'templates'
], function($, _, Backbone, Parse, JST){
    'use strict'
    
    var AboutView = Backbone.View.extend({

    	template: JST['app/scripts/templates/about.ejs'],

        contactTemplate: JST['app/scripts/templates/contact.ejs'],

    	el: '.elements',

    	events: {
    		"click .contact": "contact",
            "click .save": "send"
    		//"click .news-section": "news",
    		//"click .events-section": "listEvents"
    	},

        initialize: function(){
            _.bindAll(this, 'render');
            this.render();
        },

        contact: function(e) {
            this.$el.html(this.contactTemplate());
        },

        send: function(e) {

            var Feedback = Parse.Object.extend('Feedback');

            var contact = new Feedback();

            var email = $('#email').val();
            var message = $('textarea#message').val();

            console.log(message);

            if ((!email) || (!message)) {
                if(!email)
                    alert('Le champ \'email\' est non rempli! Nous en avons besoin pour garder contact!');
                if(!message)
                    alert('Le champ \'message\' est non rempli! Vous avez bien quelque chose à dire!');
                else
                    alert('Les champs sont à remplir obligatoirement');
            }
            else {
                contact.set("email", email);
                contact.set("message", message);

                contact.save(null, {
                    success: function(gameScore) {
                        // Execute any logic that should take place after the object is saved.
                        alert('Feedback bien sauvegardé avec l\'id: ' + contact.id);
                        Backbone.router.navigate('/', {trigger: true});
                    },
                    error: function(gameScore, error) {
                        // Execute any logic that should take place if the save fails.
                        // error is a Parse.Error with an error code and message.
                        alert('Failed to create new object, with error code: ' + error.message);
                    }
                });
            }
        },

        render: function(){
            this.$el.html(this.template());
            return this;
        }
    });

    return AboutView;
});