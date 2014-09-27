$(document).ready(function() {

  // Place JavaScript code here...

  var TaskModel = Backbone.Model.extend({
	defaults: {
		title: '',
		description: '',
		done: false 
	},
	
	idAttribute: '_id',
	
	urlRoot: '/parties',
  
	initialize: function() {
		console.log('Instanciation du modèle');
	}
});

var taskModel = new TaskModel({title: 'Démo de synchronisation', description: 'Apprentissage de la synchronisation des modèles Backbone'});

console.log(taskModel.toJSON());

});
