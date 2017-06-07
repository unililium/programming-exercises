attribute vec3 inPosition;
attribute vec3 inNormal;

varying vec3 fsNormal;
varying vec3 fsPosition;

uniform mat4 wvpMatrix;
uniform mat4 nMatrix; // Normal matrix
uniform mat4 pMatrix;

void main() {
	fsPosition = (pMatrix * vec4(inPosition, 1.0)).xyz;
	fsNormal = mat3 (nMatrix) * inNormal;
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}
