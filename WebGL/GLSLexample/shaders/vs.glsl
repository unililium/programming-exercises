attribute vec3 inPosition;
attribute vec3 inNormal;

varying vec3 fsNormal;

uniform mat4 pMatrix;

void main() {
    fsNormal = inNormal;
    gl_Position = pMatrix * vec4(inPosition, 1.0);
}
