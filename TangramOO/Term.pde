class Term extends Shape {
  String _elements;

  Term(String elements, int x, int y) {
    super(new PVector(x, y), 0, 2, color(#314EFF), false);
    setElements(elements);
  }

  Term(int elements, float scaling) {
    setElements(elements);
    setScaling(scaling);
  }
  /*
  @Override
   void cambiarCoordenadas(int x, int y) {
   }
   */

  @Override
    void seleccionar(int x, int y) {
    if ( x>=position().x && x<= position().x+180 && y<=position().y && y>=position().y-18*scaling()) {
      setSeleccion(!seleccion());
    } else {
      setSeleccion(false);
    }
  }

  @Override
    void aspect() {
    noStroke();
    text(_elements, 0, 0);
  }

  String elements() {
    return _elements;
  }

  void setElements(String elements) {
    _elements = elements;
  }

  void setElements(int elements) {
    _elements = new String();
    // see: https://discourse.processing.org/t/get-random-letters-and-put-into-a-string/28585/10
    for (int i = 0; i < elements; i++) {
      _elements += char (int(random (65, 65+24)));
    }
  }
}
