precision mediump float; 

uniform vec4 mDiffColor; //material diffuse color 
uniform vec4 mSpecColor; //material specular color
uniform float mSpecPower; //power of specular ref

uniform vec3 lightDirection; // directional light direction vec
uniform vec4 lightColor; //directional light color 

//uniform vec3 eyePosition; //Observer's position

varying vec3 fsNormal; //Interpolated normals from the previous shader
varying vec3 fsPosition; //Surface infos 

void main() { 

	vec3 nEyeDirection = normalize( - fsPosition);
	vec3 nLightDirection = - normalize(lightDirection);
	vec3 nNormal = normalize(fsNormal);
	
	vec4 diffuse = mDiffColor * lightColor * clamp(dot(nLightDirection,nNormal), 0.0, 1.0);
	
	vec3 hVec = normalize(nEyeDirection + nLightDirection);
	
	vec4 blinnSpecular = mSpecColor * lightColor * pow(clamp(dot(nNormal,hVec), 0.0, 1.0), mSpecPower);
	
	gl_FragColor = min(diffuse + blinnSpecular, vec4(1.0, 1.0, 1.0, 1.0)); 
	}