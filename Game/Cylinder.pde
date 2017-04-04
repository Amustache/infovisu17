/**
 * Define a cylinder
 */
int cBase = 100;
int cHeight = 50;
int cResolution = 40;

PShape openCylinder = new PShape();

void initCylinder() {
  stroke(102,84,94);
  fill(246,224,181);
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
  openCylinder.beginShape(QUAD_STRIP);
  //draw the border of the cylinder
  for (int i = 0; i < x.length; i++) {
    openCylinder.vertex(x[i], y[i], 0);
    openCylinder.vertex(x[i], y[i], cHeight);
  }
  openCylinder.endShape();
}

class Cylinder {
  PVector location;
  
  public Cylinder(PVector location_) {
    this.location = location_;
  }
  
  void display() {
    pushMatrix();
    {
      translate(location.x, -BOX_THICKNESS/2 - cHeight, location.z);
      lights();
      shape(openCylinder);
    }
    popMatrix();
  }
  
  void display2D() {
    pushMatrix();
    {
      stroke(102,84,94);
      fill(246,224,181);
      translate(CENTER_X, CENTER_Y);
      ellipse(location.x, location.z, cBase * 2, cBase * 2);
    }
    popMatrix();
  }
}
/*
class Cylinder {
  int cBase;// = 50;
  int cHeight;// = 50;
  int cResolution;// = 40;
  PVector location;// = new PVector();
  PShape openCylinder;// = new PShape();
  PShape cylinder2D;// = new PShape();

  Cylinder(int cBase_, int cHeight_, int cResolution_, PVector location_) {
    this.cBase = cBase_;
    this.cHeight = cHeight_;
    this.cResolution = cResolution_;
    this.location = location_;
    this.openCylinder = new PShape();
    this.cylinder2D = new PShape();
  }

  void display() {
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
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], y[i], 0);
      openCylinder.vertex(x[i], y[i], cHeight);
    }
    openCylinder.endShape();
  }

  void display2D() {

    cylinder2D = createShape();
    float angle;
    float[] x = new float[cResolution + 1];
    float[] y = new float[cResolution + 1];
    //get the x and y position on a circle for all the sides
    for (int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cResolution) * i;
      x[i] = sin(angle) * cBase;
      y[i] = cos(angle) * cBase;
    }

    cylinder2D.beginShape(TRIANGLE_FAN);
    for (int i = 0; i < cResolution+1; ++i) {
      vertex(x[i], y[i]);
    }
    cylinder2D.endShape();
  }
}*/

// conditions to may add a cylinder 
void cylinderMode() {
  lights();
  pushMatrix();
  {
    fill(255, 255, 255);
    stroke(0);
    rect(CENTER_X - BOX_WIDTH / 2, CENTER_Y - BOX_HEIGHT / 2, BOX_WIDTH, BOX_HEIGHT);
    noStroke();
  }
  popMatrix();

  boolean outOfBound = (mouseX < screenX(CENTER_X - BOX_WIDTH / 2 + CYLINDER_BASE * 2, CENTER_Y - BOX_HEIGHT / 2, 0)) // Left
    || (mouseX > screenX(CENTER_X + BOX_WIDTH / 2 - CYLINDER_BASE * 2, CENTER_Y - BOX_HEIGHT / 2, 0)) // Right
    || (mouseY < screenY(CENTER_X - BOX_WIDTH / 2, CENTER_Y - BOX_HEIGHT / 2 + CYLINDER_BASE * 2, 0)) // Up
    || (mouseY > screenY(CENTER_X + BOX_WIDTH / 2, CENTER_Y + BOX_HEIGHT / 2 - CYLINDER_BASE * 2, 0)), // Down

    onTheBall = (false), 

    onACylinder = (false);

  canAddCylinder = !outOfBound & !onTheBall & !onACylinder;

  /*if ((mouseX<(centerX+boxWidth/2)) && (mouseX>(centerX-boxWidth/2)) && (mouseY<(centerY+boxHeight/2)) && (mouseY>centerY-boxHeight/2)) {
   if (!((mouseX>(b.location.x - b.radius)) && (mouseX < (b.location.x + b.radius)) && (mouseY>(b.location.z - b.radius)) && (mouseY<(b.location.z + b.radius)))) {
   addingMode = true;
   
   }
   }*/
  /*for (Cylinder c : cylinders) {
   c.display2D();
   }*/
}