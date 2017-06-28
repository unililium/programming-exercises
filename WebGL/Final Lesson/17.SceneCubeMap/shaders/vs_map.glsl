
attribute vec3 inPosition;


uniform mat4 wvpMatrix;

varying vec3 fsPosition;


void main(){
	gl_Position =  wvpMatrix * vec4(inPosition, 1.0);
	fsPosition = inPosition;
}
