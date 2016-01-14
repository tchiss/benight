define(['jquery',
    'underscore',
    'backbone',
    'templates',
    'models/MyPartyEvent',
    'models/ReservationModel',
    'models/TicketModel',
    'models/CodeModel',
    'collections/EventsCollection',
    'views/ResaCreateView',
    'views/ReservationView'
    ], function($, _, Backbone, JST, PartyEventModel, ReservationModel, TicketModel, CodeModel, EventsCollection){
        'use strict'

    var ResaView = Backbone.View.extend({

        initialize: function(ticketObject)
        {
            console.log("fonction envoie ticket");
            console.log(ticketObject.id);
            var urltest = 'https://tickets.benight.cc/index.php?authKey=KNfCMt9TUSgYBfg&ObjectId=' + ticketObject.id;
            var codeTicket = new CodeModel();
            codeTicket.url = urltest;
            codeTicket.fetch();

            /*codeTicket.save(null, {
                type: 'POST',

                success: function(codeTicket) {
                    console.log("it happened!!");
                    console.log(codeTicket);
                },
                error: function(codeTicket, error) {
                    console.log("Failed to save object to ticket server because of : " + error.message);
                }
            });*/
        }

    });

    return ResaView;
});