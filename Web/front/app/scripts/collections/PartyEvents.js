define(['underscore',
        'backbone',
        'parse',
        'models/MyPartyEvent'
], function(_, Backbone, Parse, PartyEvent){
    'use strict'

  var PartyeventsCollection = Parse.Collection.extend({
    model: PartyEvent,

    done: function(){
        return this.filter(function(partyevent){
            return partyevent.get('done');
        });
    },

    remaining: function(){
        return this.without.apply(this, this.done());
    },

    nextOrder: function(){
        if(!this.length) return 1;
        return this.last().get('order') + 1;
    },

    comparator: function(partyevent){
        return partyevent.get('order');
    }
  });

  //Benight.Collections.PartyeventsCollection = PartyeventsCollection;
  return PartyeventsCollection;
});
