/** //<>//
 * Main program and scene
 */

/* Update, called on each frame */
void draw() {
  // Configuration de base
  setLight();
  background(bgColor);

  drawBande();
  //image(bande, 2*BOX_SIZE/7.0f + 20 + 20, 4.0f/5.0f*height + 5);
  image(bande, width/2 - bande.width/2, height - bande.height - 10);

  drawIcone();
  //image(icone, 0, 4.0f/5.0f*height);
  image(icone, width/2 - bande.width/2 + 10, height - bande.height - 5);

  drawScore();
  //image(score, BOX_SIZE/7.0f + 20, 4.0f/5.0f*height);
  image(scoreBox, width/2 - bande.width/2 + icone.width + 20, height - bande.height - 5);

  drawBarChart();
  image(barChart, width/2 - bande.width/2 + icone.width + scoreBox.width + 30, height - bande.height - 5);

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

  if (millis() - timer >= 1000) {
    scores.add(score);
    timer = millis();
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
  {
    bande.background(interfaceColor);
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
    icone.fill(plateColor);
    icone.rect(1, 1, scoreBox.width - 2, scoreBox.height - 2);
    icone.fill(ballColor);
    icone.ellipse(icone.width/2 + (ball.location.x * icone.width / BOX_SIZE), 
      icone.height/2 + (ball.location.z * icone.height / BOX_SIZE), 
      RADIUS/2, RADIUS/2);
    icone.fill(cylinderColor);
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
  scoreBox.beginDraw();
  {
    scoreBox.stroke(strokeColor);
    scoreBox.fill(plateColor);
    scoreBox.rect(1, 1, scoreBox.width - 2, scoreBox.height - 2);
    String s = "\nTotal score:\n" + score +
      "\nVelocity:\n" + (int)(sqrt(pow(ball.velocity.x, 2) + pow(ball.velocity.z, 2))) +
      "\nLast score:\n" + lastScore;
    scoreBox.fill(textColor);
    scoreBox.text(s, 2, 2);
  }
  scoreBox.endDraw();
}

public void drawBarChart() {
  lights();
  barChart.beginDraw();
  {
    barChart.stroke(strokeColor);
    barChart.fill(plateColor);
    barChart.rect(1, 1, barChart.width - 2, barChart.height - 2);

    currHeight = barChart.height - 1;
    
    barChart.stroke(strokeColor);
    barChart.fill(ballColor);
    for (int i = 0; i < score / scorePerRect; ++i) {
      barChart.rect(currWidth, currHeight, rectWidth, rectHeight);
      currHeight += rectHeight + 1;
    }
    
    currWidth += rectWidth + 1;
  }
  barChart.endDraw();
}