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

  void display(PGraphics that) {
    //fill(163, 145, 147);
    that.fill(plateColor);
    that.stroke(strokeColor);
    that.translate(width/2, height/2);
    if (cylinderModeIsOn) {
      that.rotateX(-PI/2);
    } else {
      that.rotateX(rX);
      that.rotateZ(rZ);
    }
    that.box(bWidth, bThickness, bHeight);
  }
}