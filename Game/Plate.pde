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

  void display() {
    fill(163, 145, 147);
    stroke(102, 84, 94);
    translate(width/2, height/2);
    if (cylinderModeIsOn) {
      rotateX(-PI/2);
    } else {
      rotateX(rX);
      rotateZ(rZ);
    }
    box(bWidth, bThickness, bHeight);
  }
}