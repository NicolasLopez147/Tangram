// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect) 
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...)
// 3. La evaluacion de la solucion
// 4. El modo de creacion de nuevos problemas

// (semi) standard reporting undef
// see: https://standardjs.com/#i-use-a-library-that-pollutes-the-global-namespace-how-do-i-prevent-variable-is-not-defined-errors

/* global createCanvas, Rect, push, pop, stroke,
strokeWeight, background, line, width, height */

var shapes = [];
var grid = true;

/* eslint-disable no-unused-vars */

function setup () {
  const canvas = createCanvas(600, 338);
  canvas.parent('template_js');
  for (let i = 0; i < 7; i++) {
    shapes[i] = new Rect();
  }
}

function draw () {
  background(180);
  if (grid) {
    gridHint(10);
  }
  for (var i = 0; i < shapes.length; i++) {
    shapes[i].draw();
  }
}

// (semi) standard reporting unused
/* eslint-enable no-unused-vars */

function gridHint (scale) {
  push();
  stroke(0, 255, 255);
  strokeWeight(1);
  let i;
  for (i = 0; i <= width / scale; i++) {
    line(i * scale, 0, i * scale, height);
  }
  for (i = 0; i <= height / scale; i++) {
    line(0, i * scale, width, i * scale);
  }
  pop();
}
