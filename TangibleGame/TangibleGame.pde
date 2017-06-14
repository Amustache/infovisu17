/**
 * Main program and scene
 */

/* Update, called on each frame */
void draw() {// Interface


  // Game
  full.beginDraw();
  {
    full.pushMatrix();
    // Background reset
    full.background(bgColor);

    // On affiche la plaque
    plate.display(full);

    // Puis on affiche les cylindres
    for (Obstacle c : obstacles) {
      c.display(full);
    }

    // Puis on update la balle et on vérifie les collisions
    ball.update();
    ball.checkEdges();
    ball.checkObstacleCollision(obstacles);

    // Affichage
    ball.display(full);
    full.popMatrix();
  }
  full.endDraw();
  image(full, 0, 0);

//ImageProcessing processing = new ImageProcessing();
  // Interface

  drawBande();
  image(bande, 10, height - bande.height - 10);

  drawIcone();
  image(icone, 10 + 10, height - bande.height - 5);

  drawScore();
  image(scoreBox, 10 + icone.width + 20, height - bande.height - 5);

  drawBarChart();
  image(barChart, 10 + icone.width + scoreBox.width + 30, height - bande.height - 5);

  hs.display(); 
  hs.update();
  /*
  List<PVector> corners;
          corners = hough(input, 4);  
          corners = findBestQuad(corners, width, height, height*width, height*width, true);
  */

}