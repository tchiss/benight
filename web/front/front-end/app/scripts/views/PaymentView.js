define(['jquery',
	'underscore',
	'backbone',
	'parse',
	'templates',
	'models/ReservationModel',
	'models/MyPartyEvent',
	'models/TicketModel',
    'models/PaymentModel',
	'views/ReservationView',
	'collections/ReservationCollection'
	], function($, _, Backbone, Parse, JST, PaymentModel, ReservationModel, TicketModel, ResaView){
		'use strict'

	var PaymentView = Backbone.View.extend({

		//template: JST['app/scripts/templates/PartyEvents.ejs'],

		template: JST['app/scripts/templates/payment.ejs'],

		el: '.elements',

        amount: 0,

		events: {
              "submit form.payment-form": "payment"
          },

	    // The DOM events specific to an item.

	    initialize: function(price){

            this.amount = price.amount;

	    	_.bindAll(this, 'render');
	    	this.render();
	    },

	    payment: function(e){

	    	e.preventDefault();

            var amount = this.amount;

	    	var number = $('#number').val();

       		Stripe.createToken({
            	number: $('#number').val(),
            	exp_month: $('#exp-month').val(),
            	exp_year: $('#exp-year').val(),
            	cvc: $('#cvc').val()
        	}, stripeResponseHandler);


            function stripeResponseHandler(status, response) {

                var $form = $('#payment-form');

                if (response.error) {
                    // Show the errors on the form
                    $form.find('.payment-errors').text(response.error.message);
                    $form.find('button').prop('disabled', false);
                } 
                else {
                    // response contains id and card, which contains additional card details
                    var token = response.id;

                    console.log(amount);

                    Parse.Cloud.run('purchase', {stripeToken: token, amount: amount}, {
                        success: function(results) {
                            console.log(results);
                            alert('Ticket d\'une valeur de ' + amount + ' payé!');
                            Backbone.history.navigate('', {trigger : true});
                        },
                        error: function() {
                            console.log('Cloud Code failed');
                        }
                    });
                }
            };

    			// prevent the form from submitting the default action
    			return false;
		},

	    render: function () {
	    	this.$el.html(this.template());
	    	return this;
	    }
	});

	return PaymentView;
});