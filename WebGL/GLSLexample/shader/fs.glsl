precision mediump float;

uniform vec4 mDiffColor; // cube material color
uniform vec3 lightDirection; // directional light direction
uniform vec4 lightColor;

varying vec3 col2;
void main() {
    gl_FragColor = mDiffColor * lightColor * -dot(lightDirection, fdNormal);
}
