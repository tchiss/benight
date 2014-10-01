<!doctype html>
<html>
  <head>
    <title>Mon premier rendu 3D avec Three.js</title>
    <meta charset="utf-8">
    <link  href="css/main.css" rel="stylesheet"/>
  </head>
<body>
    
  <div id="container">
  <?php
	echo 'Hello World!';
	?>
  </div>	

  <script src="http://mrdoob.github.com/three.js/build/three.min.js"></script>
  <script type="text/javascript">
      var camera, scene, renderer,
    geometry, material, cube;
 
    init();
    animate();
 
    function init() {
        scene = new THREE.Scene();
 
        camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 10000 );
        camera.position.z = 1000;
 
        geometry = new THREE.BoxGeometry( 200, 200, 200 );
        material = new THREE.MeshBasicMaterial( { color: 0xff0000, wireframe: true } );
 
        cube = new THREE.Mesh( geometry, material );
        scene.add( cube );
 
        renderer = new THREE.CanvasRenderer();
        renderer.setSize( window.innerWidth, window.innerHeight );
 
        document.body.appendChild( renderer.domElement );
    }
 
    function animate() {
        // note: three.js includes requestAnimationFrame shim
        requestAnimationFrame( animate );
        render();
    }
 
    function render() {
        cube.rotation.x += 0.01;
        cube.rotation.y += 0.02;
        renderer.render( scene, camera );
    }

  </script>
</body>
</html>