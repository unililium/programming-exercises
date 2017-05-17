attribute vec3 inPosition;  //xyz of each vertex 
attribute vec3 inNormal;	//nxnynz of each vertex normal 

varying vec3 fsNormal; 		//Interpolated normals output

uniform mat4 wvpMatrix; 	//world-view-projection matrix

void main() { 
	fsNormal = inNormal; 
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}