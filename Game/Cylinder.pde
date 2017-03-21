class Cylinder {

  float cylinderBaseSize = 50;
  float cylinderHeight = 50;
  int cylinderResolution = 40;
  PShape openCylinder = new PShape();
  void settings() {
    size(400, 400, P3D);
  }
  void setup() {
    float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] y = new float[cylinderResolution + 1];
    //get the x and y position on a circle for all the sides
    for (int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      y[i] = cos(angle) * cylinderBaseSize;
    }
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], y[i], 0);
      openCylinder.vertex(x[i], y[i], cylinderHeight);
    }
    openCylinder.endShape();
  }
  void draw() {
    background(255);
    translate(mouseX, mouseY, 0);
    shape(openCylinder);
  }
}

void cylindrerMode(){
      camera(width/2, height/2, height, width/2, height/2, 0, 0, 1, 0);
      float sizeSideX = (width - boxWidth) / 2;
      float sizeSideY = (height - boxHeight) / 2;
      lights();
      
      pushMatrix();
        fill(255, 245, 104);
        stroke(0);
        rect(width/2-(boxWidth/2), height/2-(boxHeight/2), boxWidth, boxHeight);
        noStroke();
}