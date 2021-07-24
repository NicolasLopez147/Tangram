class Paralelogramo extends Shape {
  //-----------------------------Atributos---------------------------------
  float _edge;
  //Constructor
  Paralelogramo(float edge) {
    setEdge(edge);
  }
  //-----------------------------Metodos-----------------------------------
  //Dibuja la figura segun su tipo
  @Override
    void aspect() {
    quad(0, 0, edge(), 0, edge()*(1+scaling()), edge(), scaling()*edge(), edge());
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
   PVector posicionCentro = new PVector(edge()*scaling(),edge()*scaling()/2);
   return posicionCentro;
   }
   */
  //--------------------------------Getters y setters-------------------
  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
