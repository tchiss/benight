/**
 * Les variables
 * 
 */

var renderer;                   // l'objet de rendu
var scene;                      // la scène graphique
var camera;                     // la caméra
var vector;                     // vecteur pour la camera
var pointLight;                 // lumiere
var controls;
var texture;

var planeGeometry;              // geometrie du sol
var planeMaterial;              // materiel du sol
var planeMesh;                  // mesh (= objet) sol

//var threeOBJ = require("three-obj")( options );

// appel au chargement de la page
document.addEventListener("DOMContentLoaded", Main, false);

/**
 * Fonction principale
 * Appelée au chargement de la page
 * 
**/

function    Main(){

    console.log("Main");

// configuration du rendu - renderer
// set background to have transparency - alpha: true
 if(Detector.webgl){
    renderer = new THREE.WebGLRenderer({antialias:true, alpha: true });
} else {
    renderer = new THREE.CanvasRenderer();
    } 
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setClearColor(000000, 1); 

// ajoute le rendu dans la page HTML
    document.body.appendChild(renderer.domElement);

// création de la scene
    scene = new THREE.Scene();

// création de la caméra
    camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 1, 10000);
//Position de la camera x,y,z
    camera.position.set(0, -5000, 500);
    vector = new THREE.Vector3(0, 0, 0);
//La camera regarde vers le vecteur 0,0,0
    camera.lookAt(scene.position);

// cration de la source de lumière ponctuelle (blanche)
    pointLight = new THREE.PointLight( 0xFFFFFF );
    pointLight.position.x = 10;
    pointLight.position.y = 50;
    pointLight.position.z = 130;
    scene.add(pointLight);

// Activation de la gestion du trackball par la souris dans la scène
    controls = new THREE.TrackballControls( camera, renderer.domElement );
    controls.minDistance = 1000;
    controls.maxDistance = 8000;

// création d'un sol géometrique
    planeGeometry = new THREE.PlaneGeometry(5000, 5000);
// création d'un sol matériel
    THREE.ImageUtils.crossOrigin = '';
    texture = THREE.ImageUtils.loadTexture("assets/sol.jpg");
    planeMaterial  = new THREE.MeshBasicMaterial({map:texture});
// créatin de l'objet sol (mesh) = geometry + material
    planeMesh = new THREE.Mesh(planeGeometry, planeMaterial);
    scene.add(planeMesh);

    var mesh = new THREE.GridHelper( 250, 10 );
    scene.add( mesh );
    var axis = new THREE.AxisHelper( 250 );
    scene.add( axis );


var manager = new THREE.LoadingManager();
                manager.onProgress = function ( item, loaded, total ) {

                    console.log( item, loaded, total );

                };

                // model
                var loader = new THREE.OBJLoader( manager );
                loader.load( "assets/chair.js", function ( object ) {

                    object.traverse( function ( child ) {

                        if ( child instanceof THREE.Mesh ) {

                            //child.material.map = texture;

                        }

                    } );

                    object.position.x = - 60;
                    object.rotation.x = 20* Math.PI / 180;
                    object.rotation.z = 20* Math.PI / 180;
                    object.scale.x = 30;
                    object.scale.y = 30;
                    object.scale.z = 30;
                    obj = object
                    scene.add( obj );

                } );

    renderPicture()
}

// appel la fonction de rendu

function renderPicture(){
    renderer.render(scene, camera);
    requestAnimationFrame(function(){
        planeMesh.rotation.z += 0.001;
        renderPicture();
        controls.update();
    });
}