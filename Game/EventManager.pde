/**********Mouse**********/

/* Get the absolute position of the mouse when a button is pressed */
void mousePressed() {
  absMouseX = mouseX;
  absMouseY = mouseY;
  absrX = rX;
  absrZ = rZ;
}


/* Map the relative position of the mouse to the relative position of the box */
void mouseDragged() {
  //rX = (absrX + map(absMouseY - mouseY, 0, height, 0, 2 * PI)) * speedMultiplier;
  // Angle constraints.
  if (rX > MAX_ANGLE)
    rX = MAX_ANGLE;
  if (rX < MIN_ANGLE)
    rX = MIN_ANGLE;

  rZ = (absrZ + map(mouseX - absMouseX, 0, width, 0, 2 * PI)) * speedMultiplier;
  // Angle constraints.
  if (rZ > MAX_ANGLE)
    rZ = MAX_ANGLE;
  if (rZ < MIN_ANGLE)
    rZ = MIN_ANGLE;
}

/* Control the speed multiplier with the mouse wheel */
void mouseWheel(MouseEvent event) {
  float change = event.getCount();
  speedMultiplier -= change / 10;
  if (speedMultiplier > MAX_SPEED_MULTIPLIER) {
    speedMultiplier = MAX_SPEED_MULTIPLIER;
  }
  if (speedMultiplier < MIN_SPEED_MULTIPLIER) {
    speedMultiplier = MIN_SPEED_MULTIPLIER;
  }
}

/**********Keyboard**********/

/* Keyboard settings */
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      // Zoom with UP DOWN
    case UP:
      depth -= 50 * speedMultiplier;
      break;
    case DOWN:
      depth += 50 * speedMultiplier;
      break;
    }
  }
}