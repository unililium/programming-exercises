function main() {
    var canvas = document.getElementById("my-canvas");
    var context = canvas.getContext("2d");

   for(var x = 0.5; x <= 800; x += 10) {
       context.moveTo(x, 0);
       context.lineTo(x, 600);
   }

   for(var y = 0.5; y <= 600; y += 10) {
       context.moveTo(0, y);
       context.lineTo(800, y);
   }
    context.strokeStyle = "#e43298";
    context.stroke();

    context.beginPath();

    // Draw a circle
    var segments = 64;
    var radius = 100;
    var cx = 400;
    var cy = 300;
    context.moveTo(cx + radius, cy);

    for(var i = 0; i <= segments; i++) {
        var alpha = (i / segments) * 2 * Math.PI;
        context.lineTo(cx + radius * Math.cos(alpha),
                       cy + radius * Math.sin(alpha));
    }
    context.lineWidth = 1;
    context.strokeStyle = "#1ab03b";
    context.stroke();
}
