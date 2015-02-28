/* Party Event Model */

define([
    'underscore',
    'backbone',
    'parse'
], function(_, Backbone, Parse) {
    'use strict';

  var PartyEventModel = Parse.Object.extend('Event',{

    defaults: {
        content: 'Benight Party',
        //author: 'Kalel Wilfrid',
        //theme: 'Benight',
        done: false
    },

    initialize: function() {
        if(!this.get('content')){
            this.set({
                'content': this.defaults.content
            });
        }
        /*else if(!this.get('author')){
            this.set({
                'author': this.defaults.author
            });
        }
        else if(!this.get('theme')){
            this.set({
                'theme': this.defaults.theme
            });
        }
        if(!this.get('done')){
            this.set({
                'done': this.defaults.done
            });
        }
        else
            return console.log('there si no class with those properties');*/
    },

    toggle: function() {
        this.save({
            done: !this.get('done')
        });
    }
  });

  //Benight.Models.PartyeventModel = PartyeventModel;
  return PartyEventModel;
});
