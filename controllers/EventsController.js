var EventModel = require('../models/BenightEvents');

exports.getEvents = function(req, res){
	if (req.user) return res.redirect('/');
	res.render('events/events', {
		title: 'All Events'
	});
};

exports.getSingleEvent = function(){
	return console.log("id");
};