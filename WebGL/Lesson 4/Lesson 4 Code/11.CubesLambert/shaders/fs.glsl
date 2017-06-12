precision mediump float; 

uniform vec4 mDiffColor; //material diffuse color 
uniform vec3 lightDirection; // directional light direction vec
uniform vec4 lightColor; //directional light color 

varying vec3 fsNormal; //Interpolated normals from the previous shader

void main() { 

	vec3 nNormal = normalize(fsNormal);
	
	vec4 lambertColor = mDiffColor * lightColor * max(-dot(lightDirection,nNormal), 0.0);
	gl_FragColor = min(lambertColor, vec4(1.0, 1.0, 1.0, 1.0)); 
	}