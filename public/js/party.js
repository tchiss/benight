var TaskModel = Backbone.Model.extend({
	defaults: {
		title: '',
		description: '',
		done: false 
	},
	
	idAttribute: '_id',
	
	urlRoot: '/tasks',
  
	initialize: function() {
		console.log('Instanciation du modèle');
	}
});