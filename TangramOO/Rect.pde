class Rect extends Shape {
  float _edge;

  Rect(float edge) {
    setEdge(edge);
  }

  Rect(int x, int y, float edge, color col) {
    super(new PVector(x, y), 0, 1, color(col), false);
    setEdge(edge);
  }

  @Override
    void aspect() {
    rectMode(CENTER);
    rect(0, 0, edge(), edge());
  }

  @Override
    void seleccionar(int x, int y) {
    if (get(x, y)==hue()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }
  void seleccionar(PVector posicion) {
    if (posicion.x >= position().x-(edge()/2) && posicion.x <= position().x+(edge()/2)&& posicion.y >= position().y-(edge()/2)&& posicion.y <= position().y+(edge()/2) ) {
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
