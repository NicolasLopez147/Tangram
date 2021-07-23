class Paralelogramo extends Shape {
  float _edge;

  Paralelogramo(float edge) {
    setEdge(edge);
  }
  /*
  @Override
   void cambiarCoordenadas(int x, int y) {
   if (seleccion()) {
   setPosition(new PVector(x, y));
   }
   }
   */

  @Override
    void aspect() {
    quad(0, 0, edge(), 0, 2*edge(), edge(), edge(), edge());
  }

  @Override
    void seleccionar(int x, int y) {
    if (get(x, y)==hue()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
