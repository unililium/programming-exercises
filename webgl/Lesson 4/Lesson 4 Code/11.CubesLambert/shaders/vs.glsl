attribute vec3 inPosition;  //xyz of each vertex 
attribute vec3 inNormal;	//nxnynz of each vertex normal 

varying vec3 fsNormal; 		//Interpolated normals output

uniform mat4 wvpMatrix; 	//world-view-projection matrix
uniform mat4 nMatrix; 		//matrix do transform normals

void main() { 
	fsNormal = mat3(nMatrix) * inNormal; 
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}