/* Global constants */ //<>//
final float MIN_SPEED_MULTIPLIER = 0.1, MAX_SPEED_MULTIPLIER = 20.0; // Speed constraints.
final float MIN_ANGLE = -PI/3, MAX_ANGLE = PI/3; // Angle constraints.
final float GRAVITY = 9.81;

// Scene parameters.
final float centerY = height/2 ;
final float centerX = width/2;

/* Global variables */
float speedMultiplier = 1; // Basically, speed.
float depth = 2000; // Basically, depth.

int absMouseX, absMouseY; // Absolute position of the mouse.

// Rotations.
float rX = 0; // Inclinaison of the box following X.
float rZ = 0; // Inclinaison of the box following Z.
float absrX, absrZ; // Absolute rotation of the box.

/* Settings, called on start */
void settings() {
  // fullScreen(P3D); // Because why not  
  size(1000, 1000, P3D);
}

/* Setup, called on first frame */
void setup() {
  // NULL
}

/* Update, called on each frame */
void draw() {
  lightSet();
  background(230);
  camera(centerX, centerY, depth, centerX, centerY, 0, 0, 1, 0);
  drawPlate();
  drawSphere();
}


/* Settings for light */
void lightSet() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}

/* Keyboard settings */
void keyPressed() {
  if(key == CODED) {
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

/* Get the absolute position of the mouse when a button is pressed */
void mousePressed() {
  absMouseX = mouseX;
  absMouseY = mouseY;
  absrX = rX;
  absrZ = rZ;
}

/* Map the relative position of the mouse to the relative position of the box */
void mouseDragged() {
  rX = (absrX + map(absMouseY - mouseY, 0, height, 0, 2 * PI)) * speedMultiplier;
  // Angle constraints.
  if(rX > MAX_ANGLE)
    rX = MAX_ANGLE;
  if(rX < MIN_ANGLE)
    rX = MIN_ANGLE;
    
  rZ = -(absrZ + map(absMouseX - mouseX, 0, width, 0, 2 * PI)) * speedMultiplier;
  // Angle constraints.
  if(rZ > MAX_ANGLE)
    rZ = MAX_ANGLE;
  if(rZ < MIN_ANGLE)
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