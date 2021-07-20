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
