class Term extends Shape {
  //--------------------------Atributos------------------------------------
  String _elements;
  //Constructor principal
  Term(String elements, int x, int y) {
    super(new PVector(x, y), 0, 2, color(#314EFF), false);
    setElements(elements);
  }
  //-------------------------Metodos-----------------------------------------
  //Dibuja la figura segun su tipo
  @Override
    void aspect() {
    noStroke();
    text(_elements, 0, 0);
  }
  //Selecciona la figura
  @Override
    void seleccionar(int x, int y) {
    if ( x>=position().x && x<= position().x+180 && y<=position().y && y>=position().y-18*scaling()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }

  //Calcula el centro de la figura
  /*
  @Override
   PVector centrar() {
   PVector posicionCentro = null;
   return posicionCentro;
   }
   */
  //------------------------Getters y setters---------------------------------
  String elements() {
    return _elements;
  }

  void setElements(String elements) {
    _elements = elements;
  }
}
