precision mediump float; 

uniform vec4 mDiffColor; //cube material color
uniform vec3 lightDirection; //directional light direction
uniform vec4 lightColor; 

varying vec3 fsNormal; 

void main() { 
	gl_FragColor = mDiffColor * lightColor * 
					max(-dot(lightDirection, 
						normalize(fsNormal)), 0.0) ; 
}