class Rect extends Shape {
  float _edge;

  Rect(float edge) {
    setEdge(edge);
  }

  @Override
    void aspect() {
    rectMode(CENTER);
    rect(0, 0, edge(), edge());
  }
  @Override
    void cambiarCoordenadas() {
    if (getSeleccionar()) {
      setPosition(new PVector(mouseX, mouseY));
    }
  }

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
