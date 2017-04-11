/** //<>//
 * Main program and scene
 */

/* Settings is called before anything */
/*void settings() {
 size(1200, 800, P3D);
 CENTER_X = height/2;
 CENTER_Y = width/2;
 }*/

/* Setup, called on first frame */
/*void setup() {
 cylinderModeIsOn = false;
 initCylinder();
 hs = new HScrollbar(50, 90, 300, 20);
 bande = createGraphics(5*width/7, height/5, P2D);
 icone = createGraphics(width/7, height/5, P2D);
 score = createGraphics(width/7, height/5, P2D);
 scores = 0.0;
 lastScore = 0.0;
 }*/

/* Update, called on each frame */
void draw() {
  // Configuration de base
  setLight();
  background(BG_COLOR);

  drawBande();
  //image(bande, 2*BOX_SIZE/7.0f + 20 + 20, 4.0f/5.0f*height + 5);
  image(bande, width/2 - bande.width/2, height - bande.height - 10);

  drawIcone();
  //image(icone, 0, 4.0f/5.0f*height);
  image(icone, width/2 - bande.width/2 + 5, height - bande.height - 5);

  drawScore();
  //image(score, BOX_SIZE/7.0f + 20, 4.0f/5.0f*height);
  image(score, width/2 - bande.width/2 + icone.width + 10, height - bande.height - 5);

  // On affiche la plaque
  plate.display();

  // Puis on affiche les cylindres
  for (Cylinder c : cylinders) {
    c.display();
  }

  // Puis on update la balle et on vérifie les collisions
  ball.update();
  ball.checkEdges();
  ball.checkCylinderCollision(cylinders);

  // Affichage
  ball.display();

  /*pushMatrix();
   {
   drawBande();
   image(bande, 2*BOX_SIZE/7.0f + 20 + 20, 4.0f/5.0f*height + 5);
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
   background(255);
   hs.update();
   hs.display();
   println(hs.getPos());
   }
   popMatrix();
   
   pushMatrix();
   {
   drawScore();
   image(score, BOX_SIZE/7.0f + 20, 4.0f/5.0f*height);
   }
   popMatrix();
   }*/
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
  {
    bande.background(200, 213, 183);
    //bande.stroke(240, 213, 183);
    //bande.fill(200, 213, 183);
    //bande.rect(0, 0, 5*width/7, height/5/2 + 30);
    //bande.fill(240, 180, 183);
  }
  bande.endDraw();
}

public void drawIcone() {
  lights();
  icone.beginDraw();
  {
    //icone.fill(255, 245, 104);
    icone.background(255, 245, 104);
    //icone.stroke(255);
    //icone.rect(10, 10, BOX_SIZE/7, BOX_SIZE/7);
    //icone.fill(246, 142, 86);
    icone.ellipse(icone.width/2 + (ball.location.x * icone.width / BOX_SIZE),
      icone.height/2 + (ball.location.z * icone.height / BOX_SIZE),
      RADIUS/2, RADIUS/2);
    for(Cylinder c : cylinders) {
      icone.ellipse(icone.width/2 + c.location.x * icone.width / BOX_SIZE),
        icone.height/2 + c.location.z * icone.height / BOX_SIZE),
        CYLINDER_BASE/2, CYLINDER_BASE/2);
    }
  }
  icone.endDraw();
}

public void drawScore() {
  lights();
  score.beginDraw();
  {
    //score.stroke(255);
    score.background(240, 213, 183);
    String s = "Total score:\n" + Math.round(scores*1000.0)/1000.0 + "\nVelocity:\n" + Math.round(sqrt(pow(ball.velocity.x, 2) + pow(ball.velocity.z, 2))*1000.0)/1000.0 + "\nLast score:\n" + Math.round(lastScore*1000.0)/1000.0;
    //score.fill(240, 213, 183);
    //score.rect(10, 10, BOX_SIZE/7, BOX_SIZE/7);
    score.fill(50);
    score.text(s, 15, 15, BOX_SIZE/7 - 15, BOX_SIZE/7 - 15);
  }
  score.endDraw();
}