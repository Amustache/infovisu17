//import processing.video.*;

PImage image;
Hough hough;
QuadGraph qg;

//Capture cam;
int minVotes = 50; 
PImage img, edgeDetector, blobDetection, fourCorners;
BlobDetection b;

void settings() {
  // size(1280, 480);
  size(2000, 600);
}

void setup() {
  // img = loadImage("BlobDetection_Test.bmp");
  img = loadImage("board1.jpg");
  b = new BlobDetection();

  qg = new QuadGraph();
  noLoop(); // no interactive behaviour: draw() will be called only once.

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
}

void draw() {
  // Valeurs empiriques
  int Hmin = 112; // (int)(255 * thresholdHMin.getPos());
  int Hmax = 139; // (int)(255 * thresholdHMax.getPos());
  int Smin = 98; // (int)(255 * thresholdSMin.getPos());
  int Smax = 255; // (int)(255 * thresholdSMax.getPos());
  int Bmin = 0; // (int)(255 * thresholdBMin.getPos());
  int Bmax = 151; // (int)(255 * thresholdBMax.getPos());
  int thrshld = 180; // (int)(255 * thresholdthrshld.getPos());

  edgeDetector = threshold(scharr(gaussianBlur(thresholdHSB(img, Hmin, Hmax, Smin, Smax, Bmin, Bmax))), thrshld);
  //blobDetection = b.findConnectedComponents(gaussianBlur(thresholdHSB(img, Hmin, Hmax, Smin, Smax, Bmin, Bmax)), false);
  fourCorners = threshold(scharr(gaussianBlur(edgeDetector)), thrshld); // Need add hough
  hough = new Hough(fourCorners, minVotes);
  hough.hough();

  image(edgeDetector, 1200, 0);
  //image(blobDetection, 600, 0);
  image(fourCorners, 0, 0);
  /*if (cam.available()) {
   cam.read();
   }*/

  // img = cam.get();

  image(img, 0, 0); //show image

  /*img2 = thresholdHSB(img, Hmin, Hmax, Smin, Smax, Bmin, Bmax); // HBS thresholding
   img2 = b.findConnectedComponents(img2, true); // Blob detection // <<<<<<<<<< THIS SHIT.
   img2 = gaussianBlur(img2); // Blurring
   img2 = scharr(img2); // Edge detection
   img2 = threshold(img2, thrshld); // Suppression of pixels with low brightness*/

  //image(img2, img.width, 0);
}