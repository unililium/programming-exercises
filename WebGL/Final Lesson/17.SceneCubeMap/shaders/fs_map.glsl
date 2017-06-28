precision highp float;

varying vec3 fsPosition;

uniform vec3 eyePosition;

uniform sampler2D textureFile;

vec2 inRange(vec2 v, float m) {
	return (v/(2.0*m) + vec2(0.5, 0.5)) / 4.0;
}

vec2 findPyramidTree(vec3 pos) {
	vec3 cabs = abs(pos);
	float maxAxis = max(cabs.x, max(cabs.y, cabs.z));
	vec2 outUV;
	
	if(maxAxis == cabs.x) {
		outUV = inRange(pos.zy, maxAxis);
		if(pos.x > 0.0) {
			outUV = vec2(outUV.s, 0.5 + outUV.t);
		} else {
			outUV = vec2(0.75 - outUV.s, 0.5 + outUV.t);
		}
	} else if(maxAxis == cabs.y) {
		outUV = inRange(pos.xz, maxAxis);
		if(pos.y > 0.0) {
			outUV = vec2(0.5 - outUV.s, 1.0 - outUV.t);
		} else {
			outUV = vec2(0.5 - outUV.s, 0.25 + outUV.t);
		}
	} else {
		outUV = inRange(pos.xy, maxAxis);
		if(pos.z > 0.0) {
			outUV = vec2(0.50 - outUV.s, 0.5 + outUV.t); //
		} else {
			outUV = vec2(0.75 + outUV.s , 0.5 + outUV.t );
		}
	}
	return outUV;
}

void main() {
	
	gl_FragColor = texture2D(textureFile, findPyramidTree(fsPosition - eyePosition));
}
