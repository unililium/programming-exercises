var canvas;
var gl = null;

function main() {
    canvas = document.getElementById("my-canvas");
    try {
        gl = canvas.getContext("webgl") || canvas.getContext("experimental-webgl");
    } catch(e) {
        console.log(e);
    }

    if(gl) {
        var vertices = [ -0.5, -0.5,
                         0.5, -0.5,
                         0.5, 0.5,
                         0.0, 1.0,
                         -0.5, 0.5 ];
        var VBO = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);

        //*** The (for now) obscure GLSL part... to take for granted.
            var vs = 'attribute vec2 pos1; void main() { gl_Position = vec4(pos1, 0, 1); gl_PointSize = 5.0;}';
            var fs = 'precision mediump float; void main() { gl_FragColor = vec4(0.8,0,0,1); }';
            program = gl.createProgram();
            var v1 = gl.createShader(gl.VERTEX_SHADER);
            gl.shaderSource(v1, vs);
            gl.compileShader(v1);
            var v2 = gl.createShader(gl.FRAGMENT_SHADER);
            gl.shaderSource(v2, fs)
            gl.compileShader(v2);
            gl.attachShader(program, v1);
            gl.attachShader(program, v2);
            gl.linkProgram(program);
        //*** End of the obscure part

        gl.useProgram(program);

        var vertexPositionHandle = gl.getAttribLocation(program, 'pos1');
        gl.enableVertexAttribArray(vertexPositionHandle);
        gl.vertexAttribPointer(vertexPositionHandle, 2, gl.FLOAT, false, 0, 0);

        // gl.drawArrays(gl.LINE_LOOP, 0, 5);
        // gl.drawArrays(gl.TRIANGLE_STRIP, 0, 5);
        gl.drawArrays(gl.TRIANGLE_FAN, 0, 5);
    } else {
        alert("Error");
    }
}
