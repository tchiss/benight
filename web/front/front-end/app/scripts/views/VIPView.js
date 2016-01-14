define(['jquery',
    'underscore',
    'backbone',
    'templates',
    'three'
    ], function($, _, Backbone, JST, THREE){
        'use strict'

        new VIPView = Backbone.View.extend({

        	el:'.content',

        	initialize: function(){
        		var bManualControl = false;     // contrôle manuel du panorama
        		var longitude = 0;
        		var latitude = 0;

				// sauvegardes
				var savedX;
				var savedY;
				var savedLongitude;
				var savedLatitude;

				var camera;                     // la caméra
				var renderer;                   // l'objet de rendu
				var scene;                      // la scène graphique
				var sphereMaterial;             // la sphère matérielle

				var aPanoramaImages;            // les images pour le panorama
				var iPanoramaImageChoice;       // image sélectionnée pour le panorama


				document.addEventListener("DOMContentLoaded", Main, false);

				console.log("Main");

			    // les images à mettre en panoramique
			    aPanoramaImages = ["assets/01.jpg","assets/02.jpg","assets/03.jpg","assets/04.jpg","assets/05.jpg","assets/06.jpg"];
			    
			    iPanoramaImageChoice = Math.floor( Math.random() * aPanoramaImages.length );

			    // configuration du rendu - renderer
			    renderer = new THREE.WebGLRenderer();
			    renderer.setSize(window.innerWidth, window.innerHeight);
			    
			    // ajoute le panorama dans la page HTML
			    document.getElementById("idGameDiv").appendChild(renderer.domElement);
			    
			    // création de la scene
			    scene = new THREE.Scene();
			    
			    // ajoute la caméra
			    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1000);
			    camera.target = new THREE.Vector3(0, 0, 0);

			    // création d'une sphère goémétrique
			    var sphere = new THREE.SphereGeometry(100, 100, 40);
			    sphere.applyMatrix(new THREE.Matrix4().makeScale(-1, 1, 1));

			    // création d'une sphère matérielle
			    sphereMaterial = new THREE.MeshBasicMaterial();
			    sphereMaterial.map = THREE.ImageUtils.loadTexture(aPanoramaImages[iPanoramaImageChoice])

			    // geometry + material = mesh (actual object)
			    var sphereMesh = new THREE.Mesh(sphere, sphereMaterial);
			    scene.add(sphereMesh);

			    // les écouteurs
			    document.addEventListener("mousedown", onDocumentMouseDown, false);
			    document.addEventListener("mousemove", onDocumentMouseMove, false);
			    document.addEventListener("mouseup", onDocumentMouseUp, false);
			        
			    this.render();
			},

			render: function() {

				requestAnimationFrame(renderPanorama);// enregistre la fonction pour un appel récurrent à chaque image
    
			    // si mode autoamtique
			    if(!bManualControl)
			        longitude += 0.1;

			    // limitation de la latitude entre -85 et 85 (impossible de voir le ciel ou vos pieds)
			    latitude = Math.max(-85, Math.min(85, latitude));

			    // déplace la caméra en fonction de la latitude (mouvement vertical) et de la longitude (mouvement horizontal)
			    camera.target.x = 500 * Math.sin(THREE.Math.degToRad(90 - latitude)) * Math.cos(THREE.Math.degToRad(longitude));
			    camera.target.y = 500 * Math.cos(THREE.Math.degToRad(90 - latitude));
			    camera.target.z = 500 * Math.sin(THREE.Math.degToRad(90 - latitude)) * Math.sin(THREE.Math.degToRad(longitude));
			    camera.lookAt(camera.target);

    			// appel la fonction de rendu
    			renderer.render(scene, camera);

			},

			onDocumentMouseDown: function(event) {
			    event.preventDefault();

			    bManualControl = true;

			    savedX = event.clientX;
			    savedY = event.clientY;

			    savedLongitude = longitude;
			    savedLatitude = latitude;
			},

			/**
			 * Au déplacement de la souris,
			 * mets à jour les coordonnées.
			 * 
			 * @param  {[type]} event [description]
			 * @return {[type]}       [description]
			 */
			onDocumentMouseMove: function(event)
			{
			    // mise à jour si mode manuel
			    if(bManualControl)
			    {
			        longitude = (savedX - event.clientX) * 0.1 + savedLongitude;
			        latitude = (event.clientY - savedY) * 0.1 + savedLatitude;
			    }
			},


			/**
			 * Relachement du bouton de la souris,
			 * passage en mode automatique
			 * 
			 * @param  {[type]} event [description]
			 * @return {[type]}       [description]
			 */
			onDocumentMouseUp: function(event)
			{
			    bManualControl = false;
			},



			/**
			 * Sur appui de la flèche haut,
			 * modifie l'image
			 * 
			 * @param  {[type]} event [description]
			 * @return {[type]}       [description]
			 */
			document.onkeyup = function(event)
			{
			    console.log("onkeyup");

			    // sélection d'une nouvelle image à mettre en panorama
			    iPanoramaImageChoice = (iPanoramaImageChoice + 1) % aPanoramaImages.length

			    // création du panorama
			    sphereMaterial.map = THREE.ImageUtils.loadTexture(aPanoramaImages[iPanoramaImageChoice])
			}

        });

	return VIPView;
});