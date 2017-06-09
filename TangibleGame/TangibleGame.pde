/**
 * Main program and scene
 */

/* Update, called on each frame */
void draw() {
  // Background reset
  background(bgColor);

  // Cam
  if (cam.available()) {
    cam.read();
  }
  input = cam.get();
  
  // Valeurs empiriques
  Hmin = 112;
  Hmax = 139;
  Smin = 98;
  Smax = 255;
  Bmin = 0;
  Bmax = 151;
  thrshld = 180;
  
  // Image traitée
  output = threshold(scharr(gaussianBlur(thresholdHSB(input, Hmin, Hmax, Smin, Smax, Bmin, Bmax))), thrshld);

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

  // Game
  // On affiche la plaque
  plate.display();

  // Puis on affiche les cylindres
  for (Obstacle c : obstacles) {
    c.display();
  }

  // Puis on update la balle et on vérifie les collisions
  ball.update();
  ball.checkEdges();
  ball.checkObstacleCollision(obstacles);

  // Affichage
  ball.display();
}