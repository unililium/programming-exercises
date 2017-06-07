precision mediump float;

uniform vec4 mDiffColor; //cube material color
uniform vec4 mSpecColor;
uniform float mSpecPower;

uniform vec3 lightDirection; //directional light direction
uniform vec4 lightColor;

varying vec3 eyePosition;
varying vec3 fsNormal;
varying vec3 fsPosition;

void main() {

	vec3 nEyeDirection = normalize(eyePosition - fsPosition);
	vec3 nLightDirection = -normalize(lightDirection);
	vec3 nNormal = normalize(fsNormal);

	vec4 diffuse = mDiffColor * lightColor * clamp(-dot(nLightDirection, nNormal)), 0.0, 1.0);
	vec3 hVec = normalize(nEyeDirection + nLightDirection);
	vec4 specular = mSpecColor * lightColor * pow(clamp(dot(nNormal, hVec), 0.0, 1.0), mSpecPower);
	gl_FragColor = min(diffuse + specular, vec4(1.0, 1.0, 1.0, 1.0));
}
