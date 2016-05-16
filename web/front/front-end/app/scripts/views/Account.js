define(['jquery',
        'underscore',
        'backbone',
        'parse',
        'templates'
], function($, _, Backbone, Parse, JST){
    'use strict'
    
    var AccountView = Backbone.View.extend({

    	template: JST['app/scripts/templates/account.ejs'],

        editTemplate: JST['app/scripts/templates/accountEdit.ejs'],

        homeTemplate: JST['app/scripts/templates/home.ejs'],

    	el: '.elements',

    	events: {
    		"click .edit": "edit",
            "click .save": "save"
    		//"click .news-section": "news",
    		//"click .events-section": "listEvents"
    	},

    	initialize: function(){
    		_.bindAll(this, 'render');
            var currentUser = Parse.User.current();
            if(currentUser) {
                if(!currentUser.attributes.username)
                    currentUser.attributes.username = 'Non renseigné!';
                if(!currentUser.attributes.lastname)
                    currentUser.attributes.lastname = 'Non renseigné!';
                if(!currentUser.attributes.name)
                    currentUser.attributes.name = 'Non renseigné!';
                if(!currentUser.attributes.email)
                    currentUser.attributes.email = 'Non renseigné!';
                if(!currentUser.attributes.adress)
                    currentUser.attributes.adress = 'Non renseigné!';
                if(!currentUser.attributes.phone)
                    currentUser.attributes.phone = 'Non renseigné!';
            }
            this.model = currentUser;
            this.model.on('change', this.render, this);
    		this.render();
    	},

        edit: function(e) {
            this.$el.html(this.homeTemplate());
            this.$el.html(this.editTemplate(this.model.toJSON()));
        },

        save: function(e) {

            e.preventDefault();

            var new_lastname = this.$('#inputLastname').val();
            var new_name = this.$('#inputName').val();
            var new_email = this.$('#inputEmail').val();
            var new_adress = this.$('#inputAddress').val();
            var new_phone = this.$("#inputPhone").val();

            var currentUser = this.model;

            if (new_lastname)
                currentUser.set("lastname", new_lastname);
            if (new_name)
                currentUser.set("name", new_name);
            if (new_email)
                currentUser.set("email", new_email);
            if (new_adress)
                currentUser.set("adress", new_adress);
            if (new_phone)
                currentUser.set("phone", new_phone);

            currentUser.save(null, {
                success: function(currentUser) {
                    alert("Le profil a bien été mis-à-jour!");
                },
                error: function(currentUser, error) {
                    console.log("hé non! c'est toujours ma bite!");
                }
            });
        },

    	render: function(){
            this.$el.html(this.homeTemplate());
    		this.$el.html(this.template(this.model.toJSON()));
    		return this;
    	}
    });

    return AccountView;
});