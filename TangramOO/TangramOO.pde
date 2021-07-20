// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect)
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...)
// 3. La evaluacion de la solucion
// 4. El modo de creacion de nuevos problemas

Shape[] shapes;
boolean drawGrid = true;

void setup() {
  size(800, 800);
  int borde = 1000;
  shapes = new Shape[10];
  shapes[0] = new Rect(borde/2);
  shapes[1] = new Triangulo(borde);
  shapes[2] = new Triangulo(borde);
  shapes[3] = new Triangulo(borde/2);
  shapes[4] = new Triangulo(borde/2);
  shapes[5] = new Triangulo(calcular_lado(borde));
  shapes[6] = new Paralelogramo(borde/2);
  shapes[7] = new Term("Guardar diseño", 600, 40);
  shapes[8] = new Term("Cargar diseño", 600, 80);
  shapes[9] = new Term("Modo Libre", 600, 120);
}

void drawGrid(float scale) {
  push();
  strokeWeight(1);
  int i;
  for (i=0; i<=width/scale; i++) {
    stroke(0, 0, 0, 20);
    line(i*scale, 0, i*scale, height);
  }
  for (i=0; i<=height/scale; i++) {
    stroke(0, 0, 0, 20);
    line(0, i*scale, width, i*scale);
  }
  pop();
}

void draw() {
  background(255, 255, 255);
  if (drawGrid)
    drawGrid(10);
  for (Shape shape : shapes)
    shape.draw();
}

void mousePressed() {
  for (Shape shape : shapes) {
    shape.seleccionar(mouseX, mouseY);
  }
}

void mouseWheel(MouseEvent event) {
  float sentido = event.getCount();
  for (Shape shape : shapes) {
    if (shape.getSeleccionar()) {
      shape.setRotation(sentido*(shape.rotation()+1));
      println(shape.rotation());
    }
  }
}

void keyPressed() {
  if (key == 'g' || key == 'G')
    drawGrid = !drawGrid;
}
int calcular_lado(int borde) {
  return round(pow(2*pow(borde, 2), 0.5)/2);
}
