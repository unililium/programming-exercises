precision mediump float;

uniform vec4 mDiffColor; //cube material color
uniform vec3 lightDirection; //directional light direction
uniform vec4 lightColor;

varying vec3 fsNormal;

void main() {

	vec4 lambert = mDiffColor * lightColor * clamp(-dot(lightDirection, normalize(fsNormal)), 0.0, 1.0);

	gl_FragColor = min(lambert, vec4(1.0, 1.0, 1.0, 1.0));
}
