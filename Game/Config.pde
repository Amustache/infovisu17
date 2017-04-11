/**
 * Global constants and variables
 */

/* Global constants */

// Speed constraints
final float MIN_SPEED_MULTIPLIER = 0.1, MAX_SPEED_MULTIPLIER = 20.0;

// Angle constraints
final float MIN_ANGLE = -PI/3, MAX_ANGLE = PI/3;

// Ball
final float GRAVITY = 9.81 / 10;
final float ELASTICITY = 0.7;
final float NORMAL_FORCE = 1;
final float MU = 0.01;
final float FRICTION_MAGNITUDE = NORMAL_FORCE * MU;
final int RADIUS = 25;

// Box
final int BOX_SIZE = 500;
final int BOX_THICKNESS = 20;

// Cylinder
final int CYLINDER_BASE = 50;
final int CYLINDER_HEIGHT = 50;
final int CYLINDER_RESOLUTION = 40;

// Scene parameters.
float CENTER_X;// = width/2;
float CENTER_Y;// = height/2;
final int BG_COLOR = 230;

/* Global variables */

// Booleans
boolean cylinderModeIsOn = false, canAddCylinder = false;
boolean fullscreen = false;

float speedMultiplier = 0.1;
float depth = 2000;

Plate plate = new Plate(BOX_SIZE, BOX_SIZE, BOX_THICKNESS);  
Mover ball = new Mover(RADIUS, new PVector(0, 0, 0), new PVector(0, 0, 0));

ArrayList<Cylinder> cylinders = new ArrayList<Cylinder>();

// Inclinaisons
float rX = 0;
float rZ = 0;

PGraphics bande;
PGraphics icone;
PGraphics score;

protected static int scores, lastScore;

HScrollbar hs;

void settings() {
  // size(400, 200, P2D);
  size(1200, 800, P3D);
  CENTER_X = height/2;
  CENTER_Y = width/2;
}

void setup() {
  cylinderModeIsOn = false;
  initCylinder();
  hs = new HScrollbar(50, 90, 300, 20);
  bande = createGraphics(5 * BOX_SIZE/5, BOX_SIZE/5 + 10, P2D);
  icone = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  score = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  scores = 0;
  lastScore = 0;
}
/*void draw() {
 background(255);
 hs.update();
 hs.display();
 println(hs.getPos());
 }*/