/**
 * Main program and scene
 */
 
/* Settings, called on start */
void settings() {
  if(fullscreen) {
    fullScreen(P3D);
  } else {
    size(800, 800, P3D);
  }
}

/* Setup, called on first frame */
void setup() {
  cylinderModeIsOn = false;
}

/* Update, called on each frame */
void draw() {
  camera(CENTER_X, CENTER_Y, depth, CENTER_X, CENTER_Y, 0, 0, 1, 0);
  setLight();
  background(BG_COLOR);
  if(cylinderModeIsOn) {
    cylinderMode();
    ball.display2D();
  } else {
    plate.update();
    plate.display();
    ball.update();
    ball.display();
    ball.checkEdges();
    ball.checkCylinderCollision(cylinders);
  }
}

/* Settings for light */
void setLight() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}