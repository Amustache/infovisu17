public void drawBande() {
  //lights();
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
  //lights();
  icone.beginDraw();
  {
    icone.background(interfaceColor);
    icone.stroke(0);
    icone.fill(plateColor);
    icone.rect(1, 1, scoreBox.width - 2, scoreBox.height - 2);
    icone.fill(ballColor);
    icone.ellipse(map(ball.location.x, -250, 250, 1, scoreBox.width - 2), map(ball.location.z, -250, 250, 1, scoreBox.height - 2), RADIUS/2, RADIUS/2);
    icone.fill(cylinderColor);
    for (Obstacle c : obstacles) {
      icone.rect(map(c.location.x, -250, 250, 1, scoreBox.width - 2), map(c.location.z, -250, 250, 1, scoreBox.height - 2), CYLINDER_BASE/4, CYLINDER_BASE/4);
    }
  }
  icone.endDraw();
}

public void drawScore() {
  //lights();
  scoreBox.beginDraw();
  {
    scoreBox.background(interfaceColor);
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

void drawBarChart() {
  //lights();
  barChart.beginDraw();
  {
    barChart.background(interfaceColor);
    barChart.stroke(strokeColor);
    barChart.fill(plateColor);
    barChart.rect(1, 1, barChart.width - 2, (barChart.height - 2)*5/7);

    if (!cylinderModeIsOn && millis() - timer >= 500) {
      if (Math.abs(score) > max) {
        max = Math.abs(score);
      }
      scores.add(score);
      timer = millis();
    }

    int pos = 1;
    for (int sc : scores) {
      if (sc > 0) {
        barChart.fill(0, 255, 0);
      } else {
        barChart.fill(255, 0, 0);
      }

      barChart.rect(pos, ((barChart.height - 2)*5/7)/2, rectWidth*hs.getPos(), map(-sc, 0, max, 0, ((barChart.height - 2)*5/7)/2));
      pos += rectWidth*hs.getPos();
    }
  }
  barChart.endDraw();
}