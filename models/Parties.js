var mongoose = require('mongoose');

var PartiesSchema = new mongoose.Schema({
	_id: mongoose.Schema.Types.ObjectId,
	name: { type: String, default: '' },
	date: {type: Date, default:''},
	location: { type: String, default: '' }, // Type à changer. Le vrai type est la location google map à récupérer
	theme: { type: String, default: '' },
	done: {type: Boolean, default: ''}
});

PartiesSchema.methods.GoogleMapsLocation = function(location){
	//... Récupération
	return location;
};

module.exports = mongoose.model('Party', PartiesSchema);