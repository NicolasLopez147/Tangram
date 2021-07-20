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

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
