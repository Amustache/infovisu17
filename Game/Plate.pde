/**
 * Define the game plate
 */
class Plate {
  int bWidth;// = 1000;
  int bHeight;// = 1000;
  int bThickness;// = 40;

  Plate(int bWidth_, int bHeight_, int bThickness_) {
    bWidth = bWidth_;
    bHeight = bHeight_;
    bThickness = bThickness_;
  }

  void update() {
    translate(CENTER_X, CENTER_Y);
    rotateBox();
  }

  void display() {
    box(bWidth, bThickness, bHeight);
    fill(255);
    stroke(150, 150, 0);
  }

  /* Control inclinaison with mouse */
  void rotateBox() {
    rotateX(rX);
    rotateZ(rZ);
  }
}