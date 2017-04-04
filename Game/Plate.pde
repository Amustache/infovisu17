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
  }

  void display() {
    fill(163, 145, 147);
    stroke(102, 84, 94);
    box(bWidth, bThickness, bHeight);
  }

  /* Control inclinaison with mouse */
  void rotateBox() {
    rotateX(rX);
    rotateZ(rZ);
  }
}