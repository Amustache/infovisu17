class Plate {
    // Box parameters.
  final int bWidth;// = 1000;
  final int bHeight;// = 1000;
  final int bThickness;// = 40;
  
  Plate(int bWidth_, int bHeight_, int bThickness_) {
    bWidth = bWidth_;
    bHeight = bHeight_;
    bThickness = bThickness_;
  }

  void update() {
    translate(centerX, centerY);
    rotateBox();
  }
  
  void display() {
    box(boxWidth, boxThickness, boxHeight);
    fill(255);
    stroke(150, 150, 0);
  }

  /* Control inclinaison with mouse */
  void rotateBox() {
    // float rX = map(-(mouseY - origineY), 0, height, 0, PI/3);  
    // float rZ = map(-(mouseX - origineX), 0, height, 0, PI/3);
    rotateX(rX);
    rotateZ(rZ);
  }
}