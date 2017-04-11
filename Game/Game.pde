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
  image(icone, width/2 - bande.width/2 + 10, height - bande.height - 5);

  drawScore();
  //image(score, BOX_SIZE/7.0f + 20, 4.0f/5.0f*height);
  image(score, width/2 - bande.width/2 + icone.width + 20, height - bande.height - 5);
  
  drawVisualizer();
  image(visualizer, width/2 - bande.width/2 + icone.width + score.width + 30, height - bande.height - 5);

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
    icone.stroke(0);
    icone.fill(163, 145, 147);
    icone.rect(1, 1, score.width - 2, score.height - 2);
    icone.fill(238, 169, 144);
    icone.ellipse(icone.width/2 + (ball.location.x * icone.width / BOX_SIZE), 
      icone.height/2 + (ball.location.z * icone.height / BOX_SIZE), 
      RADIUS/2, RADIUS/2);
    icone.fill(246, 224, 181);
    for (Cylinder c : cylinders) {
      icone.ellipse(icone.width/2 + c.location.x * icone.width / BOX_SIZE, 
        icone.height/2 + c.location.z * icone.height / BOX_SIZE, 
        CYLINDER_BASE/2, CYLINDER_BASE/2);
    }
  }
  icone.endDraw();
}

public void drawScore() {
  lights();
  score.beginDraw();
  {
    score.stroke(0);
    score.fill(240, 213, 183);
    score.rect(1, 1, score.width - 2, score.height - 2);
    String s = "\nTotal score:\n" + scores +
      "\nVelocity:\n" + (int)(sqrt(pow(ball.velocity.x, 2) + pow(ball.velocity.z, 2))) +
      "\nLast score:\n" + lastScore;
    score.fill(50);
    score.text(s, 2, 2);
  }
  score.endDraw();
}

public void drawVisualizer() {
  lights();
  visualizer.beginDraw();
  {
    visualizer.stroke(0);
    visualizer.fill(240, 213, 183);
    visualizer.rect(1, 1, visualizer.width - 2, visualizer.height - 2);
    
    // Stuff (?)
    
  }
  visualizer.endDraw();
}