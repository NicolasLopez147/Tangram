class Paralelogramo extends Shape {
  float _edge;

  Paralelogramo(float edge) {
    setEdge(edge);
  }
  
  @Override
    void cambiarCoordenadas(int x, int y) {
    if (getSeleccionar()) {
      setPosition(new PVector(x, y));
    }
  }
  
  @Override
    void aspect() {
    quad(0, 0, edge(), 0, 2*edge(), edge(), edge(), edge());
  }

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
