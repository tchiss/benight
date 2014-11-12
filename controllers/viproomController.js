var viproommodel = require('../models/BenightVipRoomModel');
var three = require('three');

exports.getTemplate = function(req, res){
	 if (req.user) return res.redirect('/');
  res.render('events/viproom', {
    title: 'VIP Empire'
  });
}