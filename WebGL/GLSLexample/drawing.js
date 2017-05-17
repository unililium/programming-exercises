var canvas;
var gl = null,
	shaderProgram = null;

var shaderDir = "/shaders/";

var projectionMatrix,		//stack max
	perspectiveMatrix,		//perspective - frustum
	viewMatrix,				//camera matrix
	worldMatrix;			//position / rotation / scale of the cube

var VBO, IBO;

var vertexPositionHandle, vertexColorHandle, matrixPositionHandle;

//Create camera parameters
var cx = 0.5;
var cy = 0.0;
var cz = 1.0;
var elevation = 0.0;
var angle = -30.0;

var delta = 0.1;

//Create cube parameters
var cubeTx = 0.0;
var cubeTy = 0.0;
var cubeTz = -1.0;
var cubeRx = 0.0;
var cubeRy = 0.0;
var cubeRz = 0.0;
var cubeS = 0.5;
var flag  = 0;

var lastUpdateTime = (new Date).getTime();

function main(){

	canvas=document.getElementById("my-canvas");
	try{
		gl = canvas.getContext("webgl") || canvas.getContext("experimental-webgl");
	}catch(e){
		 console.log(e);
	}
	if(gl){

		var w = canvas.clientWidth;
		var h = canvas.clientHeight;

		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.viewport(0.0,0.0, w, h);

		perspectiveMatrix = utils.MakePerspective(90, w/h, 0.1, 100.0);
		console.log(perspectiveMatrix);

		VBO = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
		gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);

		IBO = gl.createBuffer();
		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
		gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(indices), gl.STATIC_DRAW);

		utils.loadFiles([shaderDir + 'vs.glsl', shaderDir + 'fs.glsl'],
			function(shaderText) {	// callback function

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
					alert("ERROR IN FS SHADER : " + gl.getShaderInfoLog(fragmentShader));
				}

				shaderProgram = gl.createProgram();
				gl.attachShader(shaderProgram, vertexShader);
				gl.attachShader(shaderProgram, fragmentShader);
				gl.linkProgram(shaderProgram);
			}
		);

		gl.useProgram(shaderProgram);

		vertexPositionHandle = gl.getAttribLocation(shaderProgram, 'pos1');
		vertexColorHandle = gl.getAttribLocation(shaderProgram, 'col1');
		matrixPositionHandle = gl.getUniformLocation(shaderProgram, 'pMatrix');


		initInteraction();

		gl.enable(gl.DEPTH_TEST);

		drawScene();


	}else{
		alert( "Error: Your browser does not appear to support WebGL.");
	}



	function initInteraction(){
		var keyFunction = function(e) {

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
		var currenTime = (new Date).getTime();
		if(lastUpdateTime){
			var deltaC = (30* (currenTime - lastUpdateTime)) / 1000.0;

			cubeRx += deltaC;
			cubeRy -= deltaC;
			cubeRz += deltaC;

			if (flag == 0) cubeS += deltaC / 100;
			else cubeS -= deltaC / 100;

			if (cubeS>= 1.5) flag = 1;
			else if (cubeS <= 0.5) flag = 0;

		}

		worldMatrix = utils.MakeWorld( cubeTx, cubeTy, cubeTz,
										cubeRx, cubeRy, cubeRz,
										cubeS);

		lastUpdateTime = currenTime;
	}

	function computeMatrix(){
		viewMatrix = utils.MakeView(cx, cy, cz, elevation, angle);
		projectionMatrix = utils.multiplyMatrices(viewMatrix, worldMatrix);
		projectionMatrix = utils.multiplyMatrices(perspectiveMatrix, projectionMatrix);
	}

	function drawScene(){

		animate();

		computeMatrix();

		gl.uniformMatrix4fv(matrixPositionHandle, gl.FALSE, utils.transposeMatrix(projectionMatrix));

		gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
		gl.enableVertexAttribArray(vertexPositionHandle);
		gl.vertexAttribPointer(vertexPositionHandle, 3, gl.FLOAT, false, 4*6, 0);

		gl.enableVertexAttribArray(vertexColorHandle);
		gl.vertexAttribPointer(vertexColorHandle, 3, gl.FLOAT, false, 4*6, 4*3);

		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
		gl.drawElements(gl.TRIANGLES, indices.length, gl.UNSIGNED_SHORT, 0);

		//gl.drawArrays(gl.LINES, 0, 24);

		window.requestAnimationFrame(drawScene);

	}

}
