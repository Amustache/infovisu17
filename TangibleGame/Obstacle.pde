/**
 * Define a cylinder
 */
class Obstacle {
  PVector location;

  public Obstacle(PVector location_) {
    this.location = location_;
  }

  void display(PGraphics that) {
    that.stroke(strokeColor);
    that.fill(cylinderColor);
    that.pushMatrix();
    {
      that.translate(location.x, -BOX_THICKNESS/2 - CYLINDER_HEIGHT, location.z);
      //rotateX(-PI/2);
      if (cylinderModeIsOn) {
        //ellipse(0, 0, cBase * 2, cBase * 2);
        that.rotateX(-PI/2);
        that.rect(0, 0, CYLINDER_BASE, CYLINDER_BASE);
      } else {
        //shape(cylinder);
        that.rotateX(-PI);
        that.rotateY(PI);
        that.shape(s); // Blender
      }
    }
    that.popMatrix();
  }

  boolean overlapsObstacle(ArrayList<Obstacle> obstacles) {
    for (Obstacle c : obstacles) {
      if (new PVector(location.x - c.location.x, location.z - c.location.z).mag() <= 2 * CYLINDER_BASE) {
        return true;
      }
    }
    return false;
  }

  boolean overlapsBall(Mover b) {
    return new PVector(location.x - b.location.x, location.z - b.location.z).mag() <= CYLINDER_BASE + RADIUS;
  }

  boolean outOfRange() {
    return (mouseX > width/2 + BOX_SIZE / 2 - CYLINDER_BASE) // Left
      || (mouseX < width/2 - BOX_SIZE / 2 + CYLINDER_BASE) // Right
      || (mouseY < height/2 - BOX_SIZE / 2 + CYLINDER_BASE) // Up
      || (mouseY > height/2 + BOX_SIZE / 2 - CYLINDER_BASE); // Down
  }
}