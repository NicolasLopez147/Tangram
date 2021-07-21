// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect)
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...)
// 3. La evaluacion de la solucion
// 4. El modo de creacion de nuevos problemas

Shape[] shapes;
Term[] botones;
Term ganar;
PImage img;
boolean drawGrid = true;
boolean imagen;
int numDiseno = 1;
color [] colores;

void setup() {
  size(800, 600);
  int borde = 1000;
  shapes = new Shape[7];
  botones = new Term[3];
  shapes[0] = new Rect(borde/2);
  shapes[1] = new Triangulo(borde);
  shapes[2] = new Triangulo(borde);
  shapes[3] = new Triangulo(borde/2);
  shapes[4] = new Triangulo(borde/2);
  shapes[5] = new Triangulo(calcular_lado(borde));
  shapes[6] = new Paralelogramo(borde/2);

  botones[0] = new Term("Guardar diseño", 600, 40);
  botones[1] = new Term("Cargar diseño", 600, 80);
  botones[2] = new Term("Modo Libre", 600, 120);

  ganar = new Term("Felicitaciones, ha resuelto el problema", 100, 40);
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
  if (imagen)
    image(img, 0, 0, width, height);
  for (Shape shape : shapes)
    shape.draw();
  for (Term bot : botones)
    bot.draw();
  //detectarDiseno();
  if (imagen)
    validarGanar();
}

void mouseClicked() {
  for (Shape shape : shapes) {
    shape.seleccionar(mouseX, mouseY);
  }
  for (Term bot : botones) {
    bot.seleccionar(mouseX, mouseY);
  }
  for (Term bot : botones) {
    if (bot.getSeleccionar()) {
      if (bot.elements() == "Guardar diseño") {
        guardarDiseno();
      }
      if (bot.elements() == "Cargar diseño") {
        cargarDiseno();
      }
      if (bot.elements() == "Modo Libre") {
        modoLibre();
      }
    }
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
void guardarDiseno() {
  colores = new color[7];

  for (int i = 0; i < 7; i ++) {
    colores[i] = shapes[i].hue();
  }
  for (int i = 0; i < 7; i ++) {
    println(colores[i]);
  }
  for (Shape shape : shapes) {
    shape.setHue(#000000);
  }
  draw();


  guardarImagen();
  for (int i = 0; i < 7; i ++) {
    shapes[i].setHue(colores[i]);
  }
}
void guardarImagen() {
  numDiseno++;
  save("data/diseno-"+numDiseno+".jpg");
}
void cargarDiseno() {
  img = loadImage("diseno-2.jpg");
  imagen = true;
}
void modoLibre() {
  imagen = false;
}
void detectarDiseno() {
  boolean bandera= true;
  while (bandera == true) {
    try {
      img = loadImage("diseno-"+numDiseno+".jpg");
      numDiseno++;
    }
    catch(Error  e ) {
      noLoop();
      print("Hola");
      bandera = false;
    }
  }
}
void validarGanar() {
  loadPixels();
  int count = 0;
  for (int i = 0; i < pixels.length; i ++) {
    if (pixels[i] == color(#000000))
      count++;
  }
  if (count <= 30) {
    ganar.draw();
  }
  println(count);
}
