class Triangulo extends Shape {
  float _edge;

  Triangulo(float edge) {
    setEdge(edge);
  }

  @Override
    void aspect() {
    //rectMode(CENTER);
    triangle(0, 0, 0, edge(), edge(), 0);
  }

  @Override
    void seleccionar(int x, int y) {
    if (get(x, y)==hue()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }
  /*
  @Override
   void cambiarCoordenadas(int x, int y) {
   if (seleccion()) {
   setPosition(new PVector(x, y));
   }
   }
   */

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
