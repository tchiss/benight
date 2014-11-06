var viproommodel = require('../models/BenightVipRoomModel');

exports.getTemplate = function(req, res){
	 if (req.user) return res.redirect('/');
  res.render('events/viproom', {
    title: 'VIP Empire'
  });
}