define([
    'underscore',
    'backbone',
    'parse'
], function(_, Backbone, Parse) {
    'use strict';

    var CodeModel = Backbone.Model.extend({

      url : 'https://tickets.benight.cc/index.php?',

    	initialize: function () {

  			var that = this;

  			$.ajaxPrefilter( function(options, originalOptions, jqXHR) {
  				options.crossDomain = {
  					crossDomain: true
  				};
  				options.xhrFields = {
  					withCredentials: true
  				};
  			});
  		}

  	});

return CodeModel;
});