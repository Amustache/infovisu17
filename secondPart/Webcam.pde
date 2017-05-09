import processing.video.*;
Capture cam;
PImage imgW;
void webSettings() {
  size(640, 480);
}
void webSetup() {
  String[] cameras = Capture.list();
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
  }
}
void webDraw() {
  if (cam.available() == true) {
    cam.read();
  }
  imgW = cam.get();
  image(imgW, 0, 0);
}