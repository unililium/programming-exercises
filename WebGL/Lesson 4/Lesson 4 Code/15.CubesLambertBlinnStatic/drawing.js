var canvas;
var gl = null,
	shaderProgram = null;
	
var shaderDir = "/shaders/";
	
var perspectiveMatrix,	projectionMatrix,	
	viewMatrix;
	
var vertexPositionHandle, vertexNormalHandle, matrixPositionHandle, 
	materialDiffColorHandle, lightDirectionHandle, lightColorHandle,
	eyePositionHandle, 	materialSpecColorHandle, materialSpecPowerHandle;

var VBO, IBO;

//define directional light
var dirLightAlpha = -utils.degToRad(60);
var dirLightBeta  = -utils.degToRad(120);

var directionalLight = [Math.cos(dirLightAlpha) * Math.cos(dirLightBeta),
						Math.sin(dirLightAlpha),
						Math.cos(dirLightAlpha) * Math.sin(dirLightBeta)
						];
						
var directionalLightColor = new Float32Array([1.0, 1.0, 1.0, 1.0]);

//Define material color
var cubeMaterialColor = new Float32Array([0.5, 0.5, 0.5, 1.0]);
var cubeSpecularColor = new Float32Array([1.0, 0.0, 0.0, 1.0]);					
var cubeSpecularPower = 20.0;

//Parameters for Camera
var cx = 3.0;
var cy = 3.0;
var cz = 2.5;
var elevation = -45.0;
var angle = -40.0;

var delta = 0.5;

var observerPosition = new Float32Array(3);

//Cube parameters
var cubeTx = 0.0;
var cubeTy = 0.0;
var cubeTz = 0.0;
var cubeRx = 0.0;
var cubeRy = 0.0;
var cubeRz = 0.0;
var cubeS  = 0.5;

function main(){

	canvas=document.getElementById("my-canvas");
	try{
		gl = canvas.getContext("webgl", {alpha: false}) || canvas.getContext("experimental-webgl", {alpha: false});
	}catch(e){
		console.log(e);
	}
	if(gl){
		
		//Setting the size for the canvas equal to half the browser window
		var w=canvas.clientWidth;
		var h=canvas.clientHeight;
		
		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.viewport(0.0, 0.0, w, h);
		
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
				if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
					alert("Cannot link program!");
				}				
						});
		

		
		gl.useProgram(shaderProgram);
		
		vertexPositionHandle = gl.getAttribLocation(shaderProgram, 'inPosition');
		vertexNormalHandle = gl.getAttribLocation(shaderProgram, 'inNormal');
		
		matrixPositionHandle = gl.getUniformLocation(shaderProgram, 'wvpMatrix');
		
		materialDiffColorHandle = gl.getUniformLocation(shaderProgram, 'mDiffColor');
		materialSpecColorHandle = gl.getUniformLocation(shaderProgram, 'mSpecColor');
		materialSpecPowerHandle = gl.getUniformLocation(shaderProgram, 'mSpecPower');
		
		eyePositionHandle = gl.getUniformLocation(shaderProgram, 'eyePosition');

		lightDirectionHandle = gl.getUniformLocation(shaderProgram, 'lightDirection');
		lightColorHandle = gl.getUniformLocation(shaderProgram, 'lightColor');
		
		
		//Setting up the interaction using keys
		initInteraction();
		
		gl.enable(gl.DEPTH_TEST);
		
		//Rendering cycle
		drawScene();

		
	}else{
		alert( "Error: Your browser does not appear to support WebGL.");
	}
	
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



function computeMatrices(){
	viewMatrix = utils.MakeView(cx, cy, cz, elevation, angle);
	projectionMatrix = utils.multiplyMatrices(perspectiveMatrix, viewMatrix);
	
	observerPosition[0] = cx;
	observerPosition[1] = cy;
	observerPosition[2] = cz;

}
	
function drawScene(){
		

		computeMatrices();
		
		gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
		
		

		gl.uniformMatrix4fv(matrixPositionHandle, gl.FALSE, utils.transposeMatrix(projectionMatrix));

		
		gl.uniform4f(materialDiffColorHandle, cubeMaterialColor[0],
											  cubeMaterialColor[1],
											  cubeMaterialColor[2],
											  cubeMaterialColor[3]);
											  
		gl.uniform4f(materialSpecColorHandle, cubeSpecularColor[0],
											  cubeSpecularColor[1],
											  cubeSpecularColor[2],
											  cubeSpecularColor[3]);												  

		gl.uniform4f(lightColorHandle,  directionalLightColor[0],
										directionalLightColor[1],
										directionalLightColor[2],
										directionalLightColor[3]);
										
		gl.uniform1f(materialSpecPowerHandle, cubeSpecularPower);
		
		gl.uniform3f(lightDirectionHandle,  directionalLight[0],
											directionalLight[1],
											directionalLight[2]);

		gl.uniform3f(eyePositionHandle, observerPosition[0],
										observerPosition[1],
										observerPosition[2]);										
										
		gl.bindBuffer(gl.ARRAY_BUFFER, VBO);		
		gl.enableVertexAttribArray(vertexPositionHandle);
		gl.vertexAttribPointer(vertexPositionHandle, 3, gl.FLOAT, false, 6 * 4, 0);
		gl.enableVertexAttribArray(vertexNormalHandle);
		gl.vertexAttribPointer(vertexNormalHandle, 3, gl.FLOAT, false, 6 * 4, 3 * 4);		
		
		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, IBO);
		gl.drawElements(gl.TRIANGLES, indices.length,
						gl.UNSIGNED_SHORT, 0
						);
						
		gl.disableVertexAttribArray(vertexPositionHandle);
		gl.disableVertexAttribArray(vertexNormalHandle);
		
		window.requestAnimationFrame(drawScene);
}



