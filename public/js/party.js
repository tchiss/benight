// Définition d'un modèle Backbone
var PartyModel = Backbone.Model.extend({

	defaults: {
    	title: '',
    	description: '',
    	done: false 
  	},

  	idAttribute: '_id',

	urlRoot: '/parties',

	initialize: function() {
		console.log('Instanciation de la soirée');
	},

	validate: function(attrs) {
				 var errors = [];
				 if (typeof attrs.title !== 'string') {
				   errors.push('Le type pour title doit être string');
				 }
				 if (attrs.title.length === 0) {
				   errors.push('Veuillez renseigner un titre');
				 }
				 if (typeof attrs.done !== 'boolean') {
				   errors.push('Le type pour done doit être booléen');
				 }
				 console.log(errors);
				 if (errors.length > 0) return errors;
			}
});
// Définition d'une collection Backbone
var PartyCollection = Backbone.Collection.extend({
	model: PartyModel,
				
	url: '/parties',
				
	initialize: function() {
		console.log('Instanciation de la collection');
	}
});
			
// Définition d'une vue Backbone pour lister les soirées
var PartyListView = Backbone.View.extend({
	initialize: function() {
		console.log('Instanciation de la liste des soirées');
	},
				
	render: function() {
		var template = _.template($('#party-list').html(), {collection: this.collection.toJSON()});
		this.$el.html(template);
		return this;
	}
});

// Définition d'une vue Backbone pour créer une soirée
var PartyCreateView = Backbone.View.extend({
	events: {
		'click #party-create-btn': 'save'
	},

	initialize: function() {
		console.log('Instanciation de la vue de création');
	},
				
	render: function() {
		this.$el.html($('#party-create').html());
		return this;
	},

	save: function() {
		var title = $('#title').val();
		var description = $('#description').val();
		var partykModel = new PartyModel({title: title, description: description});
		if (partyModel.isValid()) {
			partyModel.save({}, {
				success: function() {
					alert('La sauvegarde a réussie');
				},
				error: function() {
					alert('La sauvegarde a échouée');
				}
			});
		};
		return false;
	}
});

// Définition d'une vue Backbone pour modifier une tâche
var PartyEditView = Backbone.View.extend({
	initialize: function() {
		console.log('Instanciation de la vue de modification');
	},

	events: {
		'click #party-edit-btn': 'save',
                 'click #party-delete-btn': 'remove'
	},
				
	render: function() {
		var template = _.template($('#party-edit').html(), {model: this.model.toJSON()});
		this.$el.html(template);
		return this;
	},

	save: function() {
		var title = $('#title').val();
		var description = $('#description').val();
		var done = $('#done').prop('checked');
					
		this.model.set('title', title);
		this.model.set('description', description);
		this.model.set('done', done);
		if (this.model.isValid()) {
			this.model.save({}, {
				success: function() {
					alert('La modification a réussie');
				},
				error: function() {
					alert('La modification a échouée');
				}
			});
		};
		return false;
	},
                
             remove: function() {
                 this.model.destroy({
                    success: function() {
                         alert('La supppresion a réussie');
                     },
                     error: function() {
                         alert('La suppression a échouée');
                     } 
                 });
             }
});
			
var AppRouter = Backbone.Router.extend({
	routes: {
		// Route par défaut
		'': 'listParties', 
		// Lister les tâches
		'parties': 'listParties',
		// Créer une nouvelle tâche
		'parties/create': 'createParty', 
		// Éditer une tâche
		'parties/edit/:id': 'editParty'
	},

	listParties: function() {
		var partyCollection = new PartyCollection();
		partyCollection.fetch({
			success: function(col) {
				var partyListView = new PartyListView({collection: partyCollection});
				$('#container').html(partyListView.render().$el);
			},
			error: function() {
				console.log('error');
			}
		});
	},

	createParty: function() {
		var partyCreateView = new PartyCreateView();
		$('#container').html(partyCreateView.render().$el);
	},

	editParty: function(id) {
		var partyModel = new PartyModel({_id: id});
		partyModel.fetch({
			success: function() {
				var partyEditView = new PartyEditView({model: partyModel});
				$('#container').html(partyEditView.render().$el);
			},
			error: function() {
				console.log('error');
			}
		});
	}
});
			
$(document).ready(function() {
	new AppRouter();
	Backbone.history.start();
});