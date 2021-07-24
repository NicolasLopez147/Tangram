class Triangulo extends Shape {
  //---------------------------Atributos-------------------------------------
  float _edge;

  //Constructor principal
  Triangulo(float edge) {
    setEdge(edge);
  }

  //--------------------------Metodos-----------------------------------------
  //Dibuja la figura segun su tipo
  @Override
    void aspect() {
    triangle(0, 0, 0, scaling()*edge(), edge(), 0);
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
   PVector posicionCentro = new PVector(edge()/2,edge()/2);
   return posicionCentro;
   }
   */
  /*


   */
  //-------------------------------Getters y setters-----------------------------
  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
