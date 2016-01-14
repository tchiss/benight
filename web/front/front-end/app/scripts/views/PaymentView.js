define(['jquery',
	'underscore',
	'backbone',
	'parse',
	'templates',
	'models/ReservationModel',
	'models/MyPartyEvent',
	'collections/ReservationCollection'
	], function($, _, Backbone, Parse, JST){
		'use strict'

	var PaymentView = Backbone.View.extend({

		//template: JST['app/scripts/templates/PartyEvents.ejs'],

		template: JST['app/scripts/templates/payment.ejs'],

		el: '.elements',

		events: {
              "submit form.payment-form": "payment"
          },

	    // The DOM events specific to an item.

	    initialize: function(){
	    	_.bindAll(this, 'render');
	    	this.render();
	    },

	    payment: function(e){

	    	e.preventDefault();

	    	console.log('sisi on est la rpz');

	    	var number = $('#number').val();

	    	console.log(number);

       		Stripe.createToken({
            	number: $('#number').val(),
            	exp_month: $('#exp-month').val(),
            	exp_year: $('#exp-year').val(),
            	cvc: $('#cvc').val()
        	}, stripeResponseHandler);

    			// prevent the form from submitting the default action
    			return false;
		},

	    render: function () {
	    	this.$el.html(this.template());
	    	return this;
	    }
	});

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
    		console.log(token);
    		Parse.Cloud.run('chargeToken', {token: token}, {
    			success: function(results) {
    				console.log(results);
    			},
    			error: function() {
    				console.log('shit');
    			}
    		});
		}
	};

	return PaymentView;
});