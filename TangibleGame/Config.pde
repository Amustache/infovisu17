import java.awt.Color;
import java.util.*;
import processing.video.*;
import gab.opencv.*;

/* Global constants */
// [External] Tunning window
Tunning t;

PVector zero2D = new PVector(0, 0);
PVector zero3D = new PVector(0, 0, 0);
PVector oldP = new PVector(0, 0, 0);
PVector r; 

// Speed constraints
final float MIN_SPEED_MULTIPLIER = 0.1, MAX_SPEED_MULTIPLIER = 20.0;

// Blender
PShape s;

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

// Scene parameters.
// To be defined later.
float CENTER_X;
float CENTER_Y;

// Colors
int strokeColor = new Color(48, 48, 48).getRGB();
int plateColor = new Color(6, 101, 130).getRGB();
int ballColor = new Color(200, 0, 0).getRGB();
int cylinderColor = new Color(239, 236, 202).getRGB();
int bgColor = new Color(255, 255, 255).getRGB();
int interfaceColor = new Color(230, 226, 175).getRGB();
int textColor = strokeColor;

// Interface
PGraphics full, bande, icone, scoreBox, barChart, scroll, camera;
HScrollbar hs;

// Plateau de jeu
Plate plate = new Plate(BOX_SIZE, BOX_SIZE, BOX_THICKNESS);  

// Ball
Mover ball = new Mover(RADIUS, new PVector(0, 0, 0), new PVector(0, 0, 0));

// QuadGraph
QuadGraph qg = new QuadGraph();

// OpenCV
OpenCV opencv;

// Last step
TwoDThreeD dTt;
int sampleRateApprox = 25;

// ImageProcessing imgproc;

/* Global variables */
// Tunning
int Hmin, Hmax, Smin, Smax, Bmin, Bmax, thrshld;

// Mode
boolean cylinderModeIsOn = false;

// Speed of the ball
float speedMultiplier = 0.1;

// Profondeur de champs
float depth = 2000;

// Obstacles
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

// Inclinaisons
float rX = 0;
float rZ = 0;

// Score
ArrayList<Integer> scores = new ArrayList<Integer>(); 
protected static int score, lastScore, timer, max;
int currHeight, currWidth, scorePerRect, rectHeight, rectWidth;

// Camera
//Capture cam; // If camera input
Movie cam; // If movie input
PImage input, output;

void settings() {
  size(1200, 800, P3D);
}

void setup() {
  // OpenCV
  opencv = new OpenCV(this, 100, 100);

  // Set center
  CENTER_X = height/2;
  CENTER_Y = width/2;

  // Load Blender shape
  s = loadShape("toblerone.obj");
  s.scale(2.5);

  // Init mode
  cylinderModeIsOn = false;

  full = createGraphics(width, height, P3D);
  // Interface 
  bande = createGraphics(5 * (BOX_SIZE/5 + 10), BOX_SIZE/5 + 10, P2D);
  icone = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  scoreBox = createGraphics(BOX_SIZE/5, BOX_SIZE/5, P2D);
  barChart = createGraphics(3 * BOX_SIZE/5, BOX_SIZE/5, P2D);
  scroll = createGraphics(3 * BOX_SIZE/5, BOX_SIZE/5, P2D);
  camera = createGraphics(3 * (BOX_SIZE/5 + 10), 2 * (BOX_SIZE/5 + 10), P2D);
  hs = new HScrollbar(10 + icone.width + scoreBox.width + 31, height - bande.height + 74, 300, 20); // Hardcodé, basé sur GameFinal > image(scroll ...)

  // Score
  score = 0;
  lastScore = 0;
  rectWidth = 10;
  max = -5;

  // Camera
  // If camera input
  /*String[] cameras = Capture.list();
   if (cameras.length == 0) {
   println("There are no cameras available for capture.");
   exit();
   } else {
   println("Available cameras:");
   for (int i = 0; i < cameras.length; i++) {
   println(cameras[i]);
   }
   cam = new Capture(this, cameras[0]);
   cam.start();
   }*/
  // If movie input
  cam = new Movie(this, "testvideo.avi");
  cam.loop();

  // Cam
  if (cam.available()) {
    cam.read();
  }
  input = cam.get();

  // Image traitée, first call
  output = threshold(scharr(gaussianBlur(thresholdHSB(input, Hmin, Hmax, Smin, Smax, Bmin, Bmax))), thrshld);

  // [External] Tunning
  t = new Tunning();
  String []args = {"Tunning"};
  PApplet.runSketch(args, t);

  dTt = new TwoDThreeD(output.width, output.height, sampleRateApprox);
}

/* Settings for light */
void setLight() {
  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}