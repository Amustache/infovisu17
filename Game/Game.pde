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
  bande = createGraphics(5*width/7, height/5, P2D);
  icone = createGraphics(width/7, height/5, P2D);
  score = createGraphics(width/7, height/5, P2D);
   scores = 0.0;
   lastScore = 0.0;
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
        rotateX(-PI/2);
        plate.display();
      }
      ball.display2D();

      for (Cylinder c : cylinders) {
        c.display2D();
      }
      popMatrix();



      boolean outOfBound = (mouseX > width/2 + BOX_WIDTH / 2 - CYLINDER_BASE) // Left
        || (mouseX < width/2 - BOX_WIDTH / 2 + CYLINDER_BASE) // Right
        || (mouseY < height/2 - BOX_HEIGHT / 2 + CYLINDER_BASE) // Up
        || (mouseY > height/2 + BOX_HEIGHT / 2 - CYLINDER_BASE), // Down

        onTheBall = (false), 

        onACylinder = (false);

      canAddCylinder = mousePressed && !outOfBound;
    }
    popMatrix();
  } else { // NOT cylinder mode
    pushMatrix();
    {
      translate(width/2, height/2);

      pushMatrix();
      {
        rotateX(rX);
        rotateZ(rZ);
        ball.update();
        ball.display();
        plate.display();
        ball.checkEdges();
        ball.checkCylinderCollision(cylinders);
        for (Cylinder c : cylinders) {
          pushMatrix();
          {
            c.display();
          }
          popMatrix();
        }
      }
      popMatrix();
    }
    popMatrix();

    pushMatrix();
    {
      drawBande();
      image(bande, 2*BOX_WIDTH/7.0f + 20 + 20, 4.0f/5.0f*height + 5);
    }
    popMatrix();

    pushMatrix();
    {
      drawIcone();
      image(icone, 0, 4.0f/5.0f*height);
    }
    popMatrix();

    pushMatrix();
    {
      drawScore();
      image(score, BOX_WIDTH/7.0f + 20, 4.0f/5.0f*height);
    }
    popMatrix();
  }
}

/* Settings for light */
void setLight() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}

public void drawBande() {
  lights();
  bande.beginDraw();
  bande.stroke(240, 213, 183);
  bande.fill(200, 213, 183);
  bande.rect(0, 0, 5*width/7, height/5/2 + 30);
  bande.fill(240, 180, 183);
  bande.endDraw();
}

public void drawIcone() {
  lights();
  icone.beginDraw();
  icone.fill(255, 245, 104);
  icone.stroke(255);
  icone.rect(10, 10, BOX_WIDTH/7, BOX_WIDTH/7);
  icone.fill(246, 142, 86);
  icone.endDraw();
}

public void drawScore() {
  lights();
  score.beginDraw();
  score.stroke(255);
  String s = "Total score:\n" + Math.round(scores*1000.0)/1000.0 + "\nVelocity:\n" + Math.round(sqrt(pow(ball.velocity.x, 2) + pow(ball.velocity.z, 2))*1000.0)/1000.0 + "\nLast score:\n" + Math.round(lastScore*1000.0)/1000.0;
  score.fill(240, 213, 183);
  score.rect(10, 10, BOX_WIDTH/7, BOX_WIDTH/7);
  score.fill(50);
  score.text(s, 15, 15, BOX_WIDTH/7 - 15, BOX_HEIGHT/7 - 15);
  score.endDraw();
}