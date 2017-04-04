/** //<>//
 * Main program and scene
 */

/* Settings is called before anything */
void settings() {
  size(1200, 800, P3D);
  CENTER_X = height/2;
  CENTER_Y = width/2;
}

/* Setup, called on first frame */
void setup() {
  cylinderModeIsOn = false;
  initCylinder();
}

/* Update, called on each frame */
void draw() {
  setLight();
  background(BG_COLOR);
  if (cylinderModeIsOn) {
    pushMatrix();
    {
      translate(width/2, height/2);
      pushMatrix();
      {
        rotateX(PI/2);
        plate.display();
      }
      popMatrix();

      ball.display2D();

      boolean outOfBound = (mouseX > width/2 + BOX_WIDTH / 2) // Left
        || (mouseX < width/2 - BOX_WIDTH / 2) // Right
        || (mouseY < height/2 - BOX_HEIGHT / 2) // Up
        || (mouseY > height/2 + BOX_HEIGHT / 2), // Down

        onTheBall = (false), 

        onACylinder = (false);

      canAddCylinder = mousePressed && !outOfBound;
    }
    popMatrix();

    /*cylinderMode();
     ball.display2D();
     for (Cylinder c : cylinders) {
     c.display2D();
     }*/
  } else {
    pushMatrix();
    {
      translate(width/2, height/2);

      pushMatrix(); //<>//
      {
        rotateX(rX);
        rotateZ(rZ);
        ball.update();
        ball.display();
        plate.display();
        ball.checkEdges();
      }
      popMatrix();




      for (Cylinder c : cylinders) {
        pushMatrix();
        {
          translate(c.location.x, -BOX_THICKNESS/2 - cHeight, c.location.z);
          c.display();
        }
        popMatrix();
      }
    }
    popMatrix();







    /*plate.update();
     plate.display();
     ball.update();
     ball.display();
     ball.checkEdges();
     ball.checkCylinderCollision(cylinders);
     for (Cylinder c : cylinders) {
     c.display();
     }
     println();*/
  }
}

/* Settings for light */
void setLight() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}