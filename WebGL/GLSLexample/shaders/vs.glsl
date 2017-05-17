attribute vec3 pos1;
attribute vec3 col1;
varying vec3 col2;
uniform mat4 pMatrix;

void main() {
    col2 = col1;
    gl_Position = pMatrix * vec4(pos1, 1.0);
}
