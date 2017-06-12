attribute vec3 inPosition; 
attribute vec3 inNormal; 

varying vec3 fsNormal; 

uniform mat4 wvpMatrix; 


void main() { 
	fsNormal = inNormal; 
	
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}
	