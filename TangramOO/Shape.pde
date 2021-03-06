// Implementar:
// 1. El estilo del shape (e.g., stroke, stroke weight).
// 2. El método contains(int x, int y) que diga si un punto de coordenadas
// (x,y) se encuentra o no al interior del shape. Observe que esta
// función puede servir para la selección de la pieza con un puntero.
// 3. El resto de shapes que se requieran para el Tangram, como se
// hace con la clase Rect (ver Rect.pde).

abstract class Shape {
  //----------------Aributos-----------------------------------------------------
  float _rotation;
  float _scaling;
  PVector _position;
  color _hue;
  boolean _seleccionado;
  //Constructor auxiliar
  Shape() {
    this(new PVector(random(width/4, 3*width/4), random(height/4, 3*height/5)),
      0, 1, color(random(0, 255), random(0, 255), random(0, 255)), false);
  }
  //Constructor principal
  Shape(PVector position, float rotation, float scaling, color hue, boolean seleccionado) {
    setPosition(position);
    setRotation(rotation);
    setScaling(scaling);
    while (hue == #FFFFFF || hue == #000000)
      hue = color(random(0, 255), random(0, 255), random(0, 255));
    setHue(hue);
    setSeleccion(seleccionado);
  }
  //Dibuja la figura
  void draw() {
    push();
    fill(hue());
    translate(position().x, position().y);
    rotate(rotation());
    scale(scaling(), scaling());
    noStroke();
    aspect();
    pop();
  }
  // ---------------Metodos abstractos--------------------------------------------
  
  //Dibuja la figura segun su tipo
  abstract void aspect();
  //Selecciona la figura
  abstract void seleccionar(int x, int y);
  //Calcula el centro de la figura
  //abstract PVector centrar();



  //---------------Getters y setters-----------------------------------------------
  boolean seleccion() {
    return _seleccionado;
  }

  void setSeleccion(boolean seleccionado) {
    _seleccionado = seleccionado;
  }

  float scaling() {
    return _scaling;
  }

  void setScaling(float scaling) {
    _scaling = scaling;
  }

  float rotation() {
    return _rotation;
  }

  void setRotation(float rotation) {
    if (rotation < 2*PI) {
      _rotation = rotation;
    }
  }

  PVector position() {
    return _position;
  }

  void setPosition(PVector position) {
    _position = position;
  }

  color hue() {
    return _hue;
  }

  void setHue(color hue) {
    _hue = hue;
  }
}
