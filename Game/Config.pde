/**
 * Global constants and variables
 */
import java.awt.Color;

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

// Colors
int strokeColor = new Color(48, 48, 48).getRGB();
int plateColor = new Color(6, 101, 130).getRGB();
int ballColor = new Color(200, 0, 0).getRGB();
int cylinderColor = new Color(239, 236, 202).getRGB();
int bgColor = new Color(255, 255, 255).getRGB();
int interfaceColor = new Color(230, 226, 175).getRGB();
int textColor = strokeColor;

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
PGraphics scoreBox;
PGraphics barChart;
HScrollbar hs;

ArrayList<Integer> scores = new ArrayList<Integer>(); 
protected static int score, lastScore, timer;

int currHeight, currWidth, scorePerRect, rectHeight, rectWidth;

/* Settings and startup */
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
  bande = createGraphics(5 * (BOX_SIZE/5 + 10), BOX_SIZE/5 + 10, P2D);
  icone = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  scoreBox = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  barChart = createGraphics(3 * BOX_SIZE/5, BOX_SIZE/5, P2D);
  score = 0;
  lastScore = 0;
  currWidth = 1;
  scorePerRect = 10;
  rectHeight = rectWidth = 1;
}
/*void draw() {
 background(255);
 hs.update();
 hs.display();
 println(hs.getPos());
 }*/