attribute vec3 inPosition;  //xyz of each vertex 
attribute vec3 inNormal;	//nxnynz of each vertex normal 

varying vec3 fsNormal; 		//Interpolated normals output
varying vec3 fsPosition;	//Interpolated surface information

uniform mat4 wvpMatrix; 	//world-view-projection matrix
uniform mat4 nMatrix; 		//matrix do transform normals
uniform mat4 pMatrix; 		//matrix do transform positions

void main() { 
	fsNormal = mat3(nMatrix) * inNormal; 
	fsPosition = (pMatrix * vec4(inPosition, 1.0)).xyz;
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}