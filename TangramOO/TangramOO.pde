// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect)
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...)
// 3. La evaluacion de la solucion
// 4. El modo de creacion de nuevos problemas

Shape[] shapes;
Term[] botones;
Term ganar;
Rect [] botonesDiseno;
PImage img;
boolean drawGrid = true;
boolean dibujarImagen;
boolean dibujarMenu = false;
boolean dibujarBotones = true;
int numDiseno;
JSONArray disenosData;
JSONObject json;


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

  json = loadJSONObject("data/data.json");
  disenosData = json.getJSONArray("disenos");
  numDiseno = disenosData.size();
}

void drawGrid(float scale) {
  println(numDiseno);
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

  if (!dibujarMenu) {
    background(255, 255, 255);
    if (dibujarImagen)
      image(img, 0, 0, width, height);
    if (drawGrid)
      drawGrid(10);
    for (Shape shape : shapes) {
      shape.draw();
      if (shape.seleccion())
        shape.setPosition(new PVector(mouseX, mouseY));
    }
    if (dibujarBotones) {
      for (Term bot : botones)
        bot.draw();
    }
    if (dibujarImagen)
      validarGanar();
    //detectarDiseno();
  } else {
    background(#D2BFFF);
    mostarDiseno();
  }
}

void mouseClicked() {
  if (!dibujarMenu) {
    for (Shape shape : shapes) {
      shape.seleccionar(mouseX, mouseY);
    }
    for (Term bot : botones) {
      bot.seleccionar(mouseX, mouseY);
    }
    for (Term bot : botones) {
      if (bot.seleccion()) {
        if (bot.elements() == "Guardar diseño") {
          guardarDiseno();
        }
        if (bot.elements() == "Cargar diseño") {
          dibujarMenu = true;
        }
        if (bot.elements() == "Modo Libre") {
          modoLibre();
        }
      }
    }
  } else {
    for (Rect botDis : botonesDiseno) {
      botDis.seleccionar(new PVector (mouseX, mouseY));
    }
    cargarDiseno();
  }
}

void mouseWheel(MouseEvent event) {
  float sentido = event.getCount();
  for (Shape shape : shapes) {
    if (shape.seleccion()) {
      shape.setRotation(shape.rotation()+(sentido*(PI/12)));
    }
  }
}

void keyPressed() {
  if (key == 'g' || key == 'G')
    drawGrid = !drawGrid;
  if (key == ' ') {
    for (Shape shape : shapes) {
      if (shape.seleccion()) {
        shape.setScaling(shape.scaling()*-1);
      }
    }
  }
}

int calcular_lado(int borde) {
  return round(pow(2*pow(borde, 2), 0.5)/2);
}
void guardarDiseno() {
  color [] colores = new color[7];
  for (int i = 0; i < 7; i ++) {
    colores[i] = shapes[i].hue();
  }
  for (Shape shape : shapes) {
    shape.setHue(#000000);
  }
  drawGrid = false;
  dibujarBotones = false;
  draw();
  guardarImagen();
  for (int i = 0; i < 7; i ++) {
    shapes[i].setHue(colores[i]);
  }
  drawGrid = true;
  dibujarBotones = true;
}
void guardarImagen() {
  String url = "diseno-"+numDiseno+".jpg";
  JSONObject diseno = new JSONObject();
  diseno.setString("url", url);
  disenosData.setJSONObject(numDiseno, diseno);
  json.setJSONArray("disenos", disenosData);
  saveJSONObject(json, "data/data.json");
  save("data/"+url);
  numDiseno++;
}
void mostarDiseno() {
  int margen = 10;
  int ancho = width-(2*margen);
  int espacio = 5;
  int lado = 150;
  int x = margen;
  int y = margen;
  botonesDiseno = new Rect[disenosData.size()];
  for (int i = 0; i < disenosData.size(); i++) {
    JSONObject diseno = disenosData.getJSONObject(i);
    img = loadImage(diseno.getString("url"));
    if (x+lado > ancho) {
      x = margen;
      y = y+lado+espacio;
    }
    botonesDiseno[i] = new Rect(x+round(lado/2), y+round(lado/2), lado, #E82121);
    botonesDiseno[i].draw();
    image(img, x, y, lado, lado);
    x = x + espacio+lado;
    //width, height

    //largo = largo + 30+lado;
  }
}
void cargarDiseno() {
  for (int i = 0; i < disenosData.size(); i++) {
    println(botonesDiseno[i].seleccion());
    if (botonesDiseno[i].seleccion()) {
      JSONObject diseno = disenosData.getJSONObject(i);
      img = loadImage(diseno.getString("url"));
      dibujarMenu = false;
      dibujarImagen = true;
    }
  }
}
void modoLibre() {
  dibujarImagen = false;
}
void detectarDiseno() {
  boolean bandera= true;
  while (bandera == true) {
    try {
      img = loadImage("diseno-"+numDiseno+".jpg");
      numDiseno++;
      println(numDiseno);
    }
    catch(NullPointerException e) {
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
  if (count <= 100) {
    ganar.draw();
  }
  println(count);
}
