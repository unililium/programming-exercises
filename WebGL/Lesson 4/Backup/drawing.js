var canvas;
var gl = null,
	shaderProgram = null;

var shaderDir = "/shaders/";

var projectionMatrix = new Array();		//stack max
var	perspectiveMatrix,		//perspective - frustum
	viewMatrix;				//camera matrix
var	worldMatrix = new Array();			//position / rotation / scale of the cube

var normalMatrix;

var VBO, IBO;

var vertexPositionHandle, vertexNormalHandle, matrixPositionHandle,
	normalMatrixHandle, vertexMatrixHandle,
	materialDiffColorHandle, materialSpecColorHandle, materialSpecPowerHandle, lightDirectionHandle, lightColorHandle,
	eyePositionHandle;

//Light parameters
var	dirLightAlpha = -utils.degToRad(60);
var	dirLightBeta = -utils.degToRad(120);

var directionalLight = [Math.cos(dirLightAlpha) * Math.cos(dirLightBeta),
						Math.sin(dirLightAlpha),
						Math.cos(dirLightAlpha) * Math.sin(dirLightBeta)];

var directionalLightColor = [1.0, 1.0, 1.0, 1.0];

var cubeMaterialColor = [1.0, 0.5, 0.5, 1.0];
var cubeSpecularColor = [1.0, 0.3, 0.3, 1.0];

//Create camera parameters
var cx = 5.0;
var cy = 5.0;
var cz = 5.0;
var elevation = -45.0;
var angle = -45.0;

var delta = 0.5;

//Create cube parameters
var cubeTx = 0.0;
var cubeTy = 0.0;
var cubeTz = 0.0;
var cubeRx = 0.0;
var cubeRy = 0.0;
var cubeRz = 0.0;
var cubeS = 0.5;
var flag  = 0;

var lastUpdateTime = (new Date).getTime();

worldMatrix[0] = utils.MakeWorld(-3.0, 0.0, -1.5, 0.0, 0.0, 0.0, 0.5);
worldMatrix[1] = utils.MakeWorld(3.0, 0.0, -1.5, 0.0, 0.0, 0.0, 0.5);
worldMatrix[2] = utils.MakeWorld(0.0, 0.0, -3.0, 0.0, 0.0, 0.0, 0.5);

var observerPosition = Float32Array(4);

function main(){

	canvas=document.getElementById("my-canvas");
	try{
		gl = canvas.getContext("webgl", {alpha:false}) || canvas.getContext("experimental-webgl",{alpha:false});
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
			function(shaderText){

				var vertexShader = gl.createShader(gl.VERTEX_SHADER);
				gl.shaderSource(vertexShader, shaderText[0]);
				gl.compileShader(vertexShader);

				if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
					alert("ERROR IN VS SHADER : " + gl.getShaderInfoLog(vertexShader));
				}

				var fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
				gl.shaderSource(fragmentShader, shaderText[1]);
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

		vertexPositionHandle = gl.getAttribLocation(shaderProgram, 'inPosition');
		vertexNormalHandle = gl.getAttribLocation(shaderProgram, 'inNormal');
		matrixPositionHandle = gl.getUniformLocation(shaderProgram, 'wvpMatrix');

		normalMatrixHandle = gl.getUniformLocation(shaderProgram, 'nMatrix');
		vertexMatrixHandle = gl.getUniformLocation(shaderProgram, 'pMatrix');

		materialSpecColorHandle = gl.getUniformLocation(shaderProgram, 'mSpecColor');
		materialSpecPowerHandle = gl.getUniformLocation(shaderProgram, 'mSpecPower');

		materialDiffColorHandle = gl.getUniformLocation(shaderProgram, 'mDiffColor');
		lightDirectionHandle = gl.getUniformLocation(shaderProgram, 'lightDirection');
		lightColorHandle = gl.getUniformLocation(shaderProgram, 'lightColor');

		eyePositionHandle = gl.getUniformLocation(shaderProgram, 'eyePosition');


		utils.initInteraction();

		gl.enable(gl.DEPTH_TEST);

		drawScene();


	} else {
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

		worldMatrix[3] = utils.MakeWorld( cubeTx, cubeTy, cubeTz,
										cubeRx, cubeRy, cubeRz,
										cubeS);

		normalMatrix = utils.invertMatrix(utils.transposeMatrix(worldMatrix[3]));

		lastUpdateTime = currenTime;
	}

	function computeMatrix(){
		viewMatrix = utils.MakeView(cx, cy, cz, elevation, angle);

		for(i = 0; i < 4; i++) {
			projectionMatrix[i] = utils.multiplyMatrices(viewMatrix, worldMatrix[i]);
			projectionMatrix[i] = utils.multiplyMatrices(perspectiveMatrix, projectionMatrix[i]);
		}

		observerPosition[0] = cx;
		observerPosition[1] = cy;
		observerPosition[2] = cz;
	}

	function drawScene(){

		animate();

		computeMatrix();

		gl.uniform4fv(materialDiffColorHandle, new Float32Array(cubeMaterialColor));
		gl.uniform4fv(materialSpecColorHandle, new Float32Array(cubeSpecularColor));
		gl.uniform3fv(lightDirectionHandle, new Float32Array(directionalLight));
		gl.uniform4fv(lightColorHandle, new Float32Array(directionalLightColor));
		gl.uniform3fv(eyePositionHandle, observerPosition);

		for(i = 0; i < 4; i++) {
			gl.uniformMatrix4fv(matrixPositionHandle, gl.FALSE, utils.transposeMatrix(projectionMatrix[i]));

			if(i < 3) {
				gl.uniformMatrix4fv(normalMatrixHandle, gl.FALSE, utils.transposeMatrix(worldMatrix[i]));
			} else {
				gl.uniformMatrix4fv(normalMatrixHandle, gl.FALSE, utils.transposeMatrix(normalMatrix));
			}

			gl.uniformMatrix4fv(vertexMatrixHandle, gl.FALSE, utils.transposeMatrix(worldMatrix[i]));

			gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
			gl.enableVertexAttribArray(vertexPositionHandle);
			gl.vertexAttribPointer(vertexPositionHandle, 3, gl.FLOAT, false, 4*6, 0);

			gl.enableVertexAttribArray(vertexNormalHandle);
			gl.vertexAttribPointer(vertexNormalHandle, 3, gl.FLOAT, false, 4*6, 4*3);

			gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
			gl.drawElements(gl.TRIANGLES, indices.length, gl.UNSIGNED_SHORT, 0);
		}


		window.requestAnimationFrame(drawScene);

	}

}
