class Rect extends Shape {
  //--------------------------Atributos----------------------------
  float _edge;
  //Constructor auxiliar
  Rect(float edge) {
    setEdge(edge);
  }
  //Constructor heredado
  Rect(int x, int y, float edge, color col) {
    super(new PVector(x, y), 0, 1, color(col), false);
    setEdge(edge);
  }
  //--------------------------Metodos-------------------------------
  //Dibuja la figura segun su tipo
  @Override
    void aspect() {
    rect(0, 0, scaling()*edge(), scaling()*edge());
  }
  //Selecciona la figura
  @Override
    void seleccionar(int x, int y) {
    if (get(x, y)==hue()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }

  //Calcula el centro de la figura
  /*
  @Override
   PVector centrar() {
   PVector posicionCentro = new PVector((edge()*scaling())/2, (edge()*scaling())/2);
   return posicionCentro;
   }
   */
  //Metodo sobrecargado, selecciona por posicion y no por color
  void seleccionar(PVector posicion) {
    if (posicion.x >= position().x && posicion.x <= position().x+edge()&& posicion.y >= position().y && posicion.y <= position().y+edge()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }

  //------------------------------Getters y setters------------------------------
  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
