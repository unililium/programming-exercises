attribute vec3 inPosition;
attribute vec3 inNormal;

varying vec3 fsNormal;

uniform mat4 wvpMatrix;
uniform mat4 nMatrix; //Normal matrix

void main() {
	fsNormal = mat3 (nMatrix) * inNormal;
	gl_Position = wvpMatrix * vec4(inPosition, 1.0);
}
