precision highp float; 

uniform vec4 mDiffColor;
uniform vec4 mSpecColor;            
uniform float mSpecPower;

uniform vec3 lightDirection;
uniform vec4 lightColor;

uniform vec3 eyePosition;

varying vec3 fsNormal; 
varying vec3 fsPosition; 

void main() { 

	vec3 nEyeDirection = normalize(eyePosition - fsPosition);
	vec3 nlightDirection = - normalize(lightDirection);
	vec3 nNormal = normalize(fsNormal);

	vec4 diffuse =  mDiffColor * lightColor * clamp(dot(nlightDirection, nNormal), 0.0, 1.0);	
	
	vec3 hVec = normalize(nEyeDirection + nlightDirection);
	vec4 specular = mSpecColor * lightColor * pow(clamp(dot(nNormal, hVec),0.0, 1.0), mSpecPower);
	
	gl_FragColor = min(diffuse + specular, vec4(1.0, 1.0, 1.0, 1.0)); 

}