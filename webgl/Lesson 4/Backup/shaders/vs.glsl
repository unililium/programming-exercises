attribute vec3 inPosition;
attribute vec3 inNormal;

varying vec3 fsNormal;
varying vec3 fsPosition;

uniform mat4 wvpMatrix;

void main() {
	fsPosition = inPosition;
	fsNormal = inNormal;
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}
