var canvas;
var gl = null,
	shaderProgram = null;
	
var shaderDir = "/shaders/"	
	
var projectionMatrix, 		//The stack matrix passed to OpenGL
	perspectiveMatrix,		//The perspective matrix
	viewMatrix,				//The view matrix
	cubeWorldMatrix;		//World matrix
	
var vertexPositionHandle, matrixPositionHandle, vertexColorHandle;

var VBO, IBO;	

//Camera parameters definition 
var cx = 0.0;                   
var cy = 0.0;
var cz = 5.0;
var elevation = 0.0;             
var angle = 0.0;  
var delta = 0.1;
	
// Cube parameters
var cubeTx = 0.0;
var cubeTy = 0.0;
var cubeTz = 0.0;
var cubeRx = 0.0;
var cubeRy = 0.0;
var cubeRz = 0.0;
var cubeS = 0.5;
var flag = 0;	

//To animate
var lastUpdateTime = (new Date).getTime();
	
function main(){

	canvas=document.getElementById("my-canvas");
	try{
		gl = canvas.getContext("webgl") || canvas.getContext("experimental-webgl");
		
	}catch(e){
		 console.log(e);
	}
	if(gl){
		
		//Setting the size for the canvas equal to half the browser window
		var w=canvas.clientWidth;
		var h=canvas.clientHeight;
		
		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.viewport(0.0, 0.0, w, h);

		perspectiveMatrix = utils.MakePerspective(90.0, w/h, 0.1, 100.0); 
		console.log(perspectiveMatrix);
		
		// we move the matrices computation in a dedicated function...
		// called each rendering cycle...
		
		VBO = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
		
		// Creating the index buffer too
		IBO = gl.createBuffer();
		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
		gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(indices), gl.STATIC_DRAW);
		
		
		// Shader loading using external shader source files
		// basicPath+
		// To do that we call the loadFiles function in utils. It takes as many as urls to different sources
		// as wanted, reads and parses them after retrieving them using a XMLHttpRequest, then calls the callback function
		// upon the parsed text, that here is defined onfly, that as parameter has the text parsed (shaderText)
		// we exploit the javascript JSON parser
		utils.loadFiles([shaderDir + 'vs.glsl', shaderDir + 'fs.glsl'], function (shaderText) {

			
			var vertexShader = gl.createShader(gl.VERTEX_SHADER);
			gl.shaderSource(vertexShader, shaderText[0]);
			gl.compileShader(vertexShader);
			if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
				alert("ERROR IN VS SHADER : " + gl.getShaderInfoLog(vertexShader));
			}
			var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
			gl.shaderSource(fragmentShader, shaderText[1])
			gl.compileShader(fragmentShader);	
			if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
				alert("ERROR IN VS SHADER : " + gl.getShaderInfoLog(fragmentShader));
			}			
			
			shaderProgram = gl.createProgram();
			gl.attachShader(shaderProgram, vertexShader);
			gl.attachShader(shaderProgram, fragmentShader);
			gl.linkProgram(shaderProgram);	
			if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
				alert("Unable to initialize the shader program.");
			}
		});
		//*** End of shader loading
		
		//we set the GLSL just created program as the one to be used
		gl.useProgram(shaderProgram);
		
		vertexPositionHandle = gl.getAttribLocation(shaderProgram, 'pos1');
		vertexColorHandle = gl.getAttribLocation(shaderProgram, 'col1');
		matrixPositionHandle = gl.getUniformLocation(shaderProgram, 'pMatrix');
		
		console.log(vertexPositionHandle+" " + matrixPositionHandle);
		
		//setting up keys interaction...
		initInteraction();
		
		//Try without enabling it.
		gl.enable(gl.DEPTH_TEST);
		
		//Now we use a function for rendering...
		drawScene(0);
				
	}else{
		alert( "Error: Your browser does not appear to support WebGL.");
	}
	
	
	
	
	
	
	function initInteraction(){
		var keyFunction =function(e) {
			
			if (e.keyCode == 37) {	// Left arrow
				cx-=delta;
			}
			if (e.keyCode == 39) {	// Right arrow
				cx+=delta;
			}	
			if (e.keyCode == 38) {	// Up arrow
				cz-=delta;
			}
			if (e.keyCode == 40) {	// Down arrow
				cz+=delta;
			}
			if (e.keyCode == 107) {	// Add
				cy+=delta;
			}
			if (e.keyCode == 109) {	// Subtract
				cy-=delta;
			}
			
			if (e.keyCode == 65) {	// a
				angle-=delta*10.0;
			}
			if (e.keyCode == 68) {	// d
				angle+=delta*10.0;
			}	
			if (e.keyCode == 87) {	// w
				elevation+=delta*10.0;
			}
			if (e.keyCode == 83) {	// s
				elevation-=delta*10.0;
			}
			
		}
		//'window' is a JavaScript object (if "canvas", it will not work)
		window.addEventListener("keyup", keyFunction, false);
	}
	
	function animate(){
		var currentTime = (new Date).getTime();
		if (lastUpdateTime){
			var delta = (30 * (currentTime - lastUpdateTime)) / 1000.0;
			cubeRx+= delta;
			cubeRy-= delta;
			cubeRz+= delta;
			if (flag == 0) cubeS += delta / 100;
			else cubeS -= delta / 100;

			if (cubeS >= 1.5) flag = 1;
			else if (cubeS <=0.5) flag = 0;
		}
		
		cubeWorldMatrix = utils.MakeWorld(	cubeTx, cubeTy, cubeTz,
											cubeRx, cubeRy, cubeRz,
											cubeS);
		
		lastUpdateTime = currentTime;
	}
	
	
	function computeMatrix(){
		viewMatrix = utils.MakeView(cx, cy, cz, elevation, angle);
		//console.log(viewMatrix);
		projectionMatrix = utils.multiplyMatrices(viewMatrix, cubeWorldMatrix);
		projectionMatrix = utils.multiplyMatrices(perspectiveMatrix, projectionMatrix);
		//console.log(projectionMatrix);
	}
	
	//Main rendering cycle
	function drawScene(time){
		
		//Animation call
		animate();
	
		computeMatrix();
		
		gl.uniformMatrix4fv(matrixPositionHandle, gl.FALSE, utils.transposeMatrix(projectionMatrix));
		
		gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
		gl.enableVertexAttribArray(vertexPositionHandle);	
		gl.vertexAttribPointer(vertexPositionHandle, 3, gl.FLOAT, false, 4*6, 0);
		
		gl.enableVertexAttribArray(vertexColorHandle);
		gl.vertexAttribPointer(vertexColorHandle, 3, gl.FLOAT, false, 4*6, 4*3);
		
		//And finally
		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
		gl.drawElements(gl.TRIANGLES, indices.length, gl.UNSIGNED_SHORT, 0);
		
		//Then render asap the next frame
		window.requestAnimationFrame(drawScene); 
	}
}




