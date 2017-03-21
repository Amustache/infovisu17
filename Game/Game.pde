/* Global constants */ //<>//
final float MIN_SPEED_MULTIPLIER = 0.1, MAX_SPEED_MULTIPLIER = 20.0; // Speed constraints.
final float MIN_ANGLE = -PI/3, MAX_ANGLE = PI/3; // Angle constraints.
final float GRAVITY = 9.81;

final float elasticity = 0.7;
final float normalForce = 1;
final float mu = 0.01;
final float frictionMagnitude = normalForce * mu;

final int RADIUS = 50;

final int boxWidth = 1000;
final int boxHeight = 1000;
final int boxThickness = 40;

// Scene parameters.
final float centerY = height/2 ;
final float centerX = width/2;

/* Global variables */
float speedMultiplier = 0.1; // Basically, speed.
float depth = 2000; // Basically, depth.

boolean cylinderMode, addingMode;
ArrayList<Cylinder> cylinders[];

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

Plate p = new Plate(boxWidth, boxHeight, boxThickness);  
Ball b = new Ball(RADIUS, new PVector(0, 0, 0), new PVector(1, 1, 1));

/* Setup, called on first frame */
void setup() {
  cylinderMode = false;
}

/* Update, called on each frame */
void draw() {
  lightSet();
  background(230);
  camera(centerX, centerY, depth, centerX, centerY, 0, 0, 1, 0);
  if (cylinderMode) {
    cylinderMode();
    b.display2D();
  } else {
    p.update(); //<>// //<>//
    p.display();
    b.update();
    b.display();
    b.checkEdges();
    b.checkCylinderCollision(cylinders);
  }
}

/* Settings for light */
void lightSet() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}