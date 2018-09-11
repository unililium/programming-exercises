attribute vec3 inPosition;
attribute vec3 inNormal;

//varying vec3 fsNormal;

uniform mat4 wvpMatrix;

uniform vec4 mSpecColor;
uniform float mSpecPower;

uniform vec3 lightDirection;
uniform vec3 lightPosition;
uniform vec4 lightColor;
uniform int lightType;

uniform vec3 eyePosition;
varying vec2 fsUVs;
varying vec4 gouraudSpecular;
varying vec4 gouraudDiffuse;

void main() {
	fsUVs = inUVs;

	fsNormal = inNormal;

	gl_Position = wvpMatrix * vec4(inPosition, 1.0);

	vec3 nEyeDirection = normalize(eyePosition - inPosition);
	//vec3 nlightDirection = - normalize(lightDirection);
	vec3 nNormal = normalize(inNormal);


}
