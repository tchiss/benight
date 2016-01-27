define([
    'underscore',
    'backbone',
    'parse'
], function(_, Backbone, Parse) {
    'use strict';

    var PaymentModel = Backbone.Model.extend({

    	amount: 0,

    	initialize: function () {

  		}

  	});

	return PaymentModel;
});