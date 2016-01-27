define(function(){

this["JST"] = this["JST"] || {};

this["JST"]["app/scripts/templates/PartyEvents.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '            <div class="header">   \r\n                <ul class="nav navbar-nav">\r\n                    <li class="active"><a href="/" class="home-section">Home</a></li>\r\n                    <li><a href="#" class="news-section">News</a></li>\r\n                    <li><a href="#" class="events-section">Events</a></li>\r\n                    <li><a href="#">Contact</a></li>\r\n                </ul>\r\n                <ul class="nav navbar-nav navbar-right">\r\n                    <li><a href="/logout" class="log-out">Logout</a></li>\r\n                </ul>\r\n            </div>\r\n\r\n            <div class="jumbotron">\r\n                <header>Upcoming Events</header>\r\n                    <ul id="event-list">\r\n                    </ul>\r\n            </div>\r\n\r\n\r\n\r\n            <div class="footer">\r\n                <p>♥ from the Benight team</p>\r\n            </div>\r\n';

}
return __p
};

this["JST"]["app/scripts/templates/event.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="panel panel-default">\r\n    <div class="panel-heading" style="background-color: #2A0247; color: white;">\r\n    \t' +
((__t = ( author )) == null ? '' : __t) +
'\r\n    </div>\r\n    <div class="panel-body" style="background-color: #54038F; color: white;">\r\n    \t' +
((__t = ( Description )) == null ? '' : __t) +
'\r\n    </div>\r\n\r\n    <div class="panel-footer" style="background-color: #2A0247;">\r\n    \t<button class="details"><a href="#event/' +
((__t = ( objectId )) == null ? '' : __t) +
'">Détails</a></button>\r\n\t</div>\r\n</div>';

}
return __p
};

this["JST"]["app/scripts/templates/event_solo.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="panel panel-default">\r\n    <div class="panel-heading" style="background-color: #2A0247; color: white;">\r\n    \t' +
((__t = ( author )) == null ? '' : __t) +
'\r\n    </div>\r\n    <div class="panel-body" style="background-color: #54038F; color: white;">\r\n    \t' +
((__t = ( Description )) == null ? '' : __t) +
'\r\n    </div>\r\n\r\n    <div class="row">\r\n \r\n    \t\t\t<div id="payment" class="col-md-4 panel-footer text-center">\r\n    \t\t\t\t<button class="reserve" type="submit"><a href="#payment/' +
((__t = ( objectId )) == null ? '' : __t) +
'">Réserver (' +
((__t = ( price )) == null ? '' : __t) +
' euros)</a></button>\r\n\t\t\t\t</div>\r\n\r\n                <div id="photo" class="col-md-4 panel-footer text-center">\r\n                    <button id="button_photo" class="album"><a id="album" target="_blank">Album Photo</a></button>\r\n                </div>\r\n\r\n\t\t\t\t<div id="vip" class="col-md-4 panel-footer text-center">\r\n    \t\t\t\t<button class="vip"><a target="_blank" href="http://VIP.benight.cc">Espace VIP</a></button>\r\n\t\t\t\t</div>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t</table>\r\n</div>';

}
return __p
};

this["JST"]["app/scripts/templates/eventsCollection.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<ul class="events">\r\n\t<span>' +
__e( author ) +
'</span>\r\n</ul>';

}
return __p
};

this["JST"]["app/scripts/templates/home.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="header col-md-12">   \r\n    <ul class="nav navbar-nav">\r\n        <li class="active"><a href="/" class="home-section">Home</a></li>\r\n        <li><a href="#" class="news-section">News</a></li>\r\n        <li><a href="#events" class="events-section">Events</a></li>\r\n    \t<li><a href="#">Contact</a></li>\r\n    </ul>\r\n\t<ul class="nav navbar-nav navbar-right">\r\n        <li><a href="/" class="log-out">Logout</a></li>\r\n\t\t<li><a href="/#signup">Sign up</a></li>\r\n\t</ul>\r\n</div>\r\n\r\n';

}
return __p
};

this["JST"]["app/scripts/templates/login.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '    <div class="container" id="content">\r\n        <div class="row" style="height: 150px;">\r\n            <div class="col-lg-8 col-lg-offset-2 text-center">\r\n                <img src="../../styles/images/logo.png">\r\n            </div>\r\n        </div>\r\n        <p>\r\n        <p>\r\n        <div class="row" style="height: 120px;">\r\n            <div class="col-lg-6 text-center">\r\n                <a href=""><img src="../../styles/images/fb_big.png" width="350"></a>\r\n            </div>\r\n            <div class="col-lg-6 text-center">\r\n                <a href=""><img src="../../styles/images/insta.png" width="350"></a>\r\n            </div>\r\n        </div>\r\n        <div class="row" style="height: 150px;">\r\n            <div class="col-lg-4 col-lg-offset-4 text-center">\r\n                <form class="login-form">\r\n                  <input type="text" placeholder="Username" class="form-control" id="login-username">\r\n                  <input type="password" placeholder="password" class="form-control" id="login-password">\r\n                  <button type="submit" class="btn btn-success-outline" style="background-color: #38d07d; color: white; font-weight: bold;">Log In</button>\r\n                </form>\r\n            </div>\r\n        </div>\r\n        <div class="row">\r\n            <P>\r\n            <div class="col-lg-4 col-lg-offset-4 text-center">\r\n               <form class="signup-form">\r\n                    <div class="error" style="display:none"></div>\r\n                    <input type="text" id="signup-username" class="form-control" placeholder="Username" />\r\n                    <input type="email" id="signup-email" class="form-control" placeholder="email@domain.com" />\r\n                    <input type="password" id="signup-password" class="form-control" placeholder="Create a Password" />\r\n                    <button type="submit" class="btn btn-success-outline" style="background-color: #38d07d; color: white; font-weight: bold;">Sign Up</button>\r\n                </form>\r\n            </div>\r\n        </div>\r\n    </div>';

}
return __p
};

this["JST"]["app/scripts/templates/news.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '            <div class="jumbotron">\r\n                <h1>Hello Benight !</h1>\r\n                <p class="lead">The news will shortly be updated. Bear with us!</p>\r\n            </div>\r\n\r\n\r\n\r\n            <div class="footer">\r\n                <p>♥ from the Benight team</p>\r\n            </div>';

}
return __p
};

this["JST"]["app/scripts/templates/payment.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<form action="" method="POST" class="payment-form" style="text-align: center;">\r\n  <span class="payment-errors"></span>\r\n\r\n  <div class="form-row">\r\n    <label>\r\n      <span style="color:white">Card Number</span>\r\n      <input type="text" size="20" id="number"/>\r\n    </label>\r\n  </div>\r\n\r\n  <div class="form-row">\r\n    <label>\r\n      <span style="color:white">CVC</span>\r\n      <input type="text" size="4" id="cvc"/>\r\n    </label>\r\n  </div>\r\n\r\n  <div class="form-row">\r\n    <label>\r\n      <span style="color:white">Expiration (MM/YYYY)</span>\r\n      <input type="text" size="2" id="exp-month"/>\r\n    </label>\r\n    <span style="color:white"> / </span>\r\n    <input type="text" size="4" id="exp-year"/>\r\n  </div>\r\n\r\n  <button type="submit">Submit Payment</button>\r\n</form>';

}
return __p
};

this["JST"]["app/scripts/templates/reservation.ejs"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<ul class="reservation">\r\n\t<span>' +
__e( Event ) +
'</span>\r\n</ul>';

}
return __p
};

  return this["JST"];

});