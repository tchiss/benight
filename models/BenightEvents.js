var mongoose = require('mongoose');
//var ObjectId = mongoose.Schema.Types.ObjectId;

var BenightEventsSchema = new mongoose.Schema({
/*	_someId: {
		type: mongoose.Schema.ObjectId,
		default: ''
	},*/
	name: {
		type: String,
		default: ''
	},

	date: {
		type: Date,
		default: Date.now
	},

	location: {
		type: String,
		default: ''
	},

	theme: {
		type: String,
		default: ''
	},

	status: {
		type: Boolean,
		default: ''
	},
});

module.exports = mongoose.model('EventModel', BenightEventsSchema); 