// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


var Stripe = require('stripe');
Stripe.initialize('sk_test_gBZlDiTaH3bX2v8YRbjPgpFz');

/*Parse.Cloud.define("chargeToken", function(request,response)
{

	var stripeToken = request.params.token;

    Stripe.Charges.create({
    	amount: 20 * 10,
    	currency: "eur",
    	card: stripeToken
    },{
        success:function(httpResponse)
            {
                response.success("everything is OK");
            },
        error:function(httpResponse)
            {
                response.error("Error bitch better have my money"); 
            }
        });
});*/

Parse.Cloud.define("purchase", function(request, response) 
{
    Stripe.Charges.create({
        amount: request.params.amount * 100, 
        currency: "eur",
        card: request.params.stripeToken // the token id should be sent from the client
    },{
        success: function(httpResponse) {
            response.success("Purchase made!");
        },
        error: function(httpResponse) {
            response.error("Uh oh, something went wrong");
            response.error(httpResponse.message);
            // alternatively
            console.log(httpResponse.message);
        }
    });
});

Parse.Cloud.define("sendEmail", function(request, response) {
  var sendgrid = require("sendgrid");
  sendgrid.initialize("Benight", "Benight2016");
 
  var name = request.params.name;
  var email = request.params.email;
  var message = request.params.message;
 
  sendgrid.sendEmail({
   to: "benight_2016@labeip.epitech.eu",
   from: email,
   fromname: name,
   subject: "Contact depuis le site Benight",
   text: "Nom: "+name+"\nEmail: "+email+"\nMessage:\n\n"+message
   }, {
     success: function(httpResponse) {
       console.log(httpResponse);
       response.success("Email sent!");
    },
     error: function(httpResponse) {
       console.error(httpResponse);
       response.error("Uh oh, something went wrong");
    }
  });
});
