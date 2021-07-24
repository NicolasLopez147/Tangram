// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect)
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...)
// 3. La evaluacion de la solucion
// 4. El modo de creacion de nuevos problemas

//Se crea un arreglo de las figuras del tangram
Shape[] shapes;
//Se crean un arreglo de los botones que estaran en el menu principal
Term[] botonesMenu;
//Se crea el mensaje de victoria
Term ganar;
//Se crea un arreglo con los botones que estaran en el menu de los diseños
Rect [] botonesMenuDisenos;
//Objeto tipo PImage que cargara la ruta del archivo
PImage img;
//Booleanos que habilitan o inhabilitan ciertos componentes de los menus
boolean drawGrid = true;
boolean dibujarDiseno;
boolean dibujarMenuDisenos = false;
boolean dibujarBotonesMenu = true;
//Entero que tiene el numero de diseños guardados
int numDiseno;
// Objetos tipo json que guardaran la url de los diseños
JSONObject json;
JSONArray disenosData;


void setup() {
  size(800, 600);
  int borde = 100;
  //Se instancian las figuras y los botones del menu principal
  shapes = new Shape[7];
  botonesMenu = new Term[3];
  shapes[0] = new Rect(borde/2);
  shapes[1] = new Triangulo(borde);
  shapes[2] = new Triangulo(borde);
  shapes[3] = new Triangulo(borde/2);
  shapes[4] = new Triangulo(borde/2);
  shapes[5] = new Triangulo(calcular_lado(borde));
  shapes[6] = new Paralelogramo(borde/2);

  botonesMenu[0] = new Term("Guardar diseño", 600, 40);
  botonesMenu[1] = new Term("Cargar diseño", 600, 80);
  botonesMenu[2] = new Term("Modo Libre", 600, 120);

  //Se instancia el mensaje de victoria
  ganar = new Term("Felicitaciones, ha resuelto el problema", 100, 40);

  //Se conectan los objetos tipo json con el archivo data.json
  json = loadJSONObject("data/data.json");
  disenosData = json.getJSONArray("disenos");
  //Se guarda la cantidad de elementos que hay en el archivo json
  numDiseno = disenosData.size();
}

void draw() {

  //Dibuja el menu principal o el menu de los diseños
  if (!dibujarMenuDisenos) {
    background(255, 255, 255);
    //Dibuja el diseño en el menu principal
    if (dibujarDiseno)
      image(img, 0, 0, width, height);
    //Dibuja la grilla en el menu principal
    if (drawGrid)
      drawGrid(10);
    for (Shape shape : shapes) {
      //Dibuja las figuras del tangram
      shape.draw();
      //Verifica si alguna figura del tangram esta seleccionada
      if (shape.seleccion()) {
        //Setea la posicion del mouse a la figura para que sea transladada
        shape.setPosition(new PVector(mouseX, mouseY) );
        /*
        float x = shape.position().x;
         float y = shape.position().y;
         float distancia = dist(mouseX, mouseY, x, y);
         println(shape.centrar().x);
         shape.setPosition(new PVector((mouseX-shape.centrar().x), (mouseY-shape.centrar().y)) );
         */
      }
    }
    //Dibuja los botones del menu principal
    if (dibujarBotonesMenu) {
      for (Term bot : botonesMenu)
        bot.draw();
    }
    //Si hay un diseño activado valida si el usuario ya gano
    if (dibujarDiseno)
      validarGanar();
  } else {
    background(#D2BFFF);
    //Muestra el menu de los diseños
    mostarMenuDiseno();
  }
}

void mouseClicked() {
  if (!dibujarMenuDisenos) {
    //Selecciona una figura del tangram
    for (Shape shape : shapes) {
      shape.seleccionar(mouseX, mouseY);
    }
    //Selecciona un boton del menu principal
    for (Term bot : botonesMenu) {
      bot.seleccionar(mouseX, mouseY);
    }
    //Valida cual boton fue seleccionado
    for (Term bot : botonesMenu) {
      if (bot.seleccion()) {
        if (bot.elements() == "Guardar diseño") {
          //Guarda el diseño
          guardarDiseno();
        }
        if (bot.elements() == "Cargar diseño") {
          //Activa el menu de diseños
          dibujarMenuDisenos = true;
        }
        if (bot.elements() == "Modo Libre") {
          //Desactiva el diseño mostrado
          modoLibre();
        }
      }
    }
  } else {
    //Selecciona un boton del menu de diseños
    for (Rect botDis : botonesMenuDisenos) {
      botDis.seleccionar(new PVector (mouseX, mouseY));
    }
    //Carga el diseño seleccionado al menu principal
    cargarDiseno();
  }
}

void mouseWheel(MouseEvent event) {
  //Rota la figura 15 grados
  float sentido = event.getCount();
  for (Shape shape : shapes) {
    if (shape.seleccion()) {
      shape.setRotation(shape.rotation()+(sentido*(PI/12)));
    }
  }
}

void keyPressed() {
  //Inhabilita o habilita la grilla
  if (key == 'g' || key == 'G')
    drawGrid = !drawGrid;
  //Voltea la figura
  if (key == ' ') {
    for (Shape shape : shapes) {
      if (shape.seleccion()) {
        shape.setScaling(-shape.scaling());
      }
    }
  }
  //Inhabilita el menu de diseños
  if (key == 'v' || key == 'V')
    dibujarMenuDisenos = false;
}
//Dibuja la grilla
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
//Calcula el lado del triangulo mediano
int calcular_lado(int borde) {
  return round(pow(2*pow(borde, 2), 0.5)/2);
}
//Limpia el menu primcipal dejando unicamente las figuras del tangram y guarda el diseño
void guardarDiseno() {
  color [] colores = new color[7];
  for (int i = 0; i < 7; i ++) {
    colores[i] = shapes[i].hue();
  }
  for (Shape shape : shapes) {
    shape.setHue(#000000);
  }
  drawGrid = false;
  dibujarBotonesMenu = false;
  draw();
  guardarImagen();
  for (int i = 0; i < 7; i ++) {
    shapes[i].setHue(colores[i]);
  }
  drawGrid = true;
  dibujarBotonesMenu = true;
}
//Guarda la imagen tanto en el json como en formato jpg
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
//Dibuja el menu de los diseños
void mostarMenuDiseno() {
  int margen = 10;
  int ancho = width-(2*margen);
  int espacio = 5;
  int lado = 150;
  int x = margen;
  int y = margen;
  //Crea un boton por cada diseño
  botonesMenuDisenos = new Rect[disenosData.size()];
  for (int i = 0; i < disenosData.size(); i++) {
    JSONObject diseno = disenosData.getJSONObject(i);
    //Carga cada diseño del json
    img = loadImage(diseno.getString("url"));
    if (x+lado > ancho) {
      x = margen;
      y = y+lado+espacio;
    }
    botonesMenuDisenos[i] = new Rect(x, y, lado, #E82121);
    //Dibuja el boton
    botonesMenuDisenos[i].draw();
    //Dibuja el diseño
    image(img, x, y, lado, lado);
    x = x + espacio+lado;
  }
}
//Carga el diseño seleccionado
void cargarDiseno() {
  for (int i = 0; i < disenosData.size(); i++) {
    if (botonesMenuDisenos[i].seleccion()) {
      JSONObject diseno = disenosData.getJSONObject(i);
      img = loadImage(diseno.getString("url"));
      dibujarMenuDisenos = false;
      dibujarDiseno = true;
    }
  }
}
//Inhabilita el diseño en el menu principal
void modoLibre() {
  dibujarDiseno = false;
}
//Contando los pixeles negros valida si se ha resuento el nivel
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
