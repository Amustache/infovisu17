/**********Mouse**********/

/* Map the relative position of the mouse to the relative position of the box */
void mouseDragged() {

  // Following X
  if (pmouseY > mouseY)
    rX += 0.1 * speedMultiplier;
  if (pmouseY < mouseY)
    rX -= 0.1 * speedMultiplier;

  if (rX > MAX_ANGLE)
    rX = MAX_ANGLE;
  if (rX < MIN_ANGLE)
    rX = MIN_ANGLE;

  // Following Z
  if (pmouseX < mouseX)
    rZ += 0.1 * speedMultiplier;
  if (pmouseX > mouseX)
    rZ -= 0.1 * speedMultiplier;
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
    public void mouseClicked(){
      if(cylinderMode && addingMode){
        cylinders.add(new Cylinder(mouseX, mouseY));
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
    case SHIFT:
      cylinderMode = true;
    }
  }
}

public void keyReleased(){
      if(keyCode == SHIFT)
        cylinderMode = false;
    }



    