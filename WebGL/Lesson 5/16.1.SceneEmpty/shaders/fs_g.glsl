precision highp float; 

varying vec3 fsNormal; 

void main() { 

	gl_FragColor = vec4(fsNormal, 1.0); 
	
}