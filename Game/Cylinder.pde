/**
 * Define a cylinder
 */
int cBase = CYLINDER_BASE;
int cHeight = CYLINDER_HEIGHT;
int cResolution = CYLINDER_RESOLUTION;

PShape openCylinder = new PShape();
PShape topCylinder = new PShape();
PShape cylinder = new PShape();

void initCylinder() {
  stroke(102, 84, 94);
  fill(246, 224, 181);
  float angle;
  float[] x = new float[cResolution + 1];
  float[] y = new float[cResolution + 1];
  //get the x and y position on a circle for all the sides
  for (int i = 0; i < x.length; i++) {
    angle = (TWO_PI / cResolution) * i;
    x[i] = sin(angle) * cBase;
    y[i] = cos(angle) * cBase;
  }
  openCylinder = createShape();
  {
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], y[i], 0);
      openCylinder.vertex(x[i], y[i], cHeight);
    }
  }
  openCylinder.endShape();

  topCylinder = createShape();
  {
    topCylinder.beginShape(TRIANGLE_FAN);

    for (int i = 0; i < x.length; i++) {
      topCylinder.vertex(x[i], y[i], 0);
    }
  }
  topCylinder.endShape();

  cylinder = createShape(GROUP);
  {
    cylinder.addChild(openCylinder);
    cylinder.addChild(topCylinder);
  }
}

class Cylinder {
  PVector location;

  public Cylinder(PVector location_) {
    this.location = location_;
  }

  void display() {
    stroke(strokeColor);
    fill(cylinderColor);
    pushMatrix();
    {
      translate(location.x, -BOX_THICKNESS/2 - cHeight, location.z);
      //rotateX(-PI/2);
      if (cylinderModeIsOn) {
        //ellipse(0, 0, cBase * 2, cBase * 2);
        rotateX(-PI/2);
        rect(0, 0, cBase, cBase);
      } else {
        //shape(cylinder);
        rotateX(-PI);
        rotateY(PI);
        shape(s); // Blender
      }
    }
    popMatrix();
  }

  boolean overlapsCylinder(ArrayList<Cylinder> cylinders) {
    for (Cylinder c : cylinders) {
      if (new PVector(location.x - c.location.x, location.z - c.location.z).mag() <= 2 * cBase) {
        return true;
      }
    }
    return false;
  }

  boolean overlapsBall(Mover b) {
    return new PVector(location.x - b.location.x, location.z - b.location.z).mag() <= cBase + RADIUS;
  }

  boolean outOfRange() {
    return (mouseX > width/2 + BOX_SIZE / 2 - CYLINDER_BASE) // Left
      || (mouseX < width/2 - BOX_SIZE / 2 + CYLINDER_BASE) // Right
      || (mouseY < height/2 - BOX_SIZE / 2 + CYLINDER_BASE) // Up
      || (mouseY > height/2 + BOX_SIZE / 2 - CYLINDER_BASE); // Down
  }
}