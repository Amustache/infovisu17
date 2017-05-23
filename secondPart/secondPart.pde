import processing.video.*;

PImage image;
Movie camera;
//Hough hough;

Capture cam;
int minVotes = 50; 
PImage img, img2, img3;
BlobDetection b;

void settings() {
  // size(1280, 480);
    size(1600, 600);
}

void setup() {
  // img = loadImage("BlobDetection_Test.bmp");
  img = loadImage("img/board1.jpg");
  b = new BlobDetection();
  // hough = new Hough(img, minVotes);
  // noLoop(); // no interactive behaviour: draw() will be called only once.

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

void draw() {
  if (cam.available()) {
    cam.read();
  }

  // img = cam.get();

  image(img, 0, 0); //show image

  // Valeurs empiriques
  int Hmin = 112; // (int)(255 * thresholdHMin.getPos());
  int Hmax = 139; // (int)(255 * thresholdHMax.getPos());
  int Smin = 98; // (int)(255 * thresholdSMin.getPos());
  int Smax = 255; // (int)(255 * thresholdSMax.getPos());
  int Bmin = 0; // (int)(255 * thresholdBMin.getPos());
  int Bmax = 151; // (int)(255 * thresholdBMax.getPos());
  int thrshld = 180; // (int)(255 * thresholdthrshld.getPos());

  img2 = thresholdHSB(img, Hmin, Hmax, Smin, Smax, Bmin, Bmax); // HBS thresholding
  img2 = b.findConnectedComponents(img2, true); // Blob detection // <<<<<<<<<< THIS SHIT.
  img2 = gaussianBlur(img2); // Blurring
  img2 = scharr(img2); // Edge detection
  img2 = threshold(img2, thrshld); // Suppression of pixels with low brightness
  
  image(img2, img.width, 0);
  //image(img3, img.width, 0);

  //Hough h = new Hough( img, minVotes);
  //image(h.accImg, img.width, 0);

  /**PImage img2 = img.copy();
   img2.loadPixels();
   
   for (int x = 0; x < img2.width; x++)
   for (int y = 0; y < img2.height; y++)
   if (y%2==0)
   img2.pixels[y*img2.width+x] = color(0, 0, 0);
  /* appying threshold
   img2 = threshold(img, 128); */
  /*img2 = hueing(img);
   img2.updatePixels();//update pixels
   image(img2, img.width, 0);*/
}

PImage threshold(PImage img, int threshold) {
  PImage result = createImage(img.width, img.height, RGB);
  result.loadPixels();
  for (int i = 0; i < img.width * img.height; i++) {
    color neutral = color(255, 255, 255);
    if (brightness(img.pixels[i]) > threshold) {
      result.pixels[i] = neutral;
    }
  }
  result.updatePixels();
  return result;
}

PImage hueing(PImage img) {
  PImage result = createImage(img.width, img.height, RGB);
  result.loadPixels();
  for (int i = 0; i < img.width * img.height; i++) {
    float red = red(img.pixels[i]);
    float green = green(img.pixels[i]);
    float blue = blue(img.pixels[i]);
    color c = color(red, green, blue);
    result.pixels[i] = color(hue(c));
  }
  result.updatePixels();
  return result;
}

PImage hueMap(PImage img) {
  PImage result = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.width * img.height; ++i) {
    result.pixels[i] = (int)hue(img.pixels[i]);
  }
  return result;
}

PImage hueFilter(PImage img, int min, int max) {
  PImage result = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.width * img.height; i++) {
    if (hue(img.pixels[i]) > max || hue(img.pixels[i]) < min) {
      result.pixels[i] = color(0, 0, 0);
    } else {
      result.pixels[i] = img.pixels[i] ;
    }
  }
  return result;
}

PImage inverse(PImage img) {
  PImage result = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.width * img.height; ++i) {
    result.pixels[i] = Math.abs(img.pixels[i] - color(255, 255, 255));
  }
  return result;
}

PImage thresholdHSB(PImage img, int minH, int maxH, int minS, int maxS, int minB, int maxB) {
  PImage result = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.width * img.height; i++) {
    if (hue(img.pixels[i]) > maxH || hue(img.pixels[i]) < minH
      || saturation(img.pixels[i]) > maxS || saturation(img.pixels[i]) < minS
      || brightness(img.pixels[i]) > maxB || brightness(img.pixels[i]) < minB) {
      result.pixels[i] = color(0, 0, 0);
    } else {
      result.pixels[i] = color(255, 255, 255);
    }
  }
  return result;
}

boolean imagesEqual(PImage img1, PImage img2) {
  if (img1.width != img2.width || img1.height != img2.height)
    return false;
  for (int i = 0; i < img1.width*img1.height; i++)
    //assuming that all the three channels have the same value
    if (red(img1.pixels[i]) != red(img2.pixels[i]))
      return false;
  return true;
}

PImage convolute(PImage img) {
  float[][] kernel = { { 0, 0, 0 }, 
    { 0, 2, 0 }, 
    { 0, 0, 0 }};
  float normFactor = 1.f;
  // create a greyscale image (type: ALPHA) for output
  PImage result = createImage(img.width, img.height, ALPHA);
  // kernel size N = 3
  //
  // for each (x,y) pixel in the image:
  // - multiply intensities for pixels in the range
  // (x - N/2, y - N/2) to (x + N/2, y + N/2) by the
  // corresponding weights in the kernel matrix
  // - sum all these intensities and divide it by normFactor
  // - set result.pixels[y * img.width + x] to this value

  for (int x = 1; x < img.width - 1; ++x) {
    for (int y = 1; y < img.height - 1; ++y) {
      int sum = 0;
      for (int a = x - 1; a <= x + 1; a++) {
        for (int b = y - 1; b <= y + 1; b++) {
          sum += kernel[b -y +1][a -x +1] * brightness(img.pixels[b * img.width + a]);
        }
      }
      sum /= normFactor;
      result.pixels[y * img.width + x] = color(sum);
    }
  }
  return result;
}

PImage gaussianBlur(PImage img) {
  float[][] kernel = 
    {{ 9, 12, 9 }, 
    { 12, 15, 12 }, 
    { 9, 12, 9 }};
  float normFactor = 99.f;
  PImage result = createImage(img.width, img.height, ALPHA);

  for (int x = 1; x < img.width - 1; ++x) {
    for (int y = 1; y < img.height - 1; ++y) {
      int sum = 0;
      for (int a = x - 1; a <= x + 1; a++) {
        for (int b = y - 1; b <= y + 1; b++) {
          sum += kernel[b -y +1][a -x +1] * brightness(img.pixels[b * img.width + a]);
        }
      }
      sum /= normFactor;
      result.pixels[y * img.width + x] = color(sum);
    }
  }
  return result;
}

PImage scharr(PImage img) {

  float[][] hKernel = 
    {{ 3, 10, 3 }, 
    { 0, 0, 0 }, 
    { -3, -10, -3 }};
  float[][] vKernel = 
    {{ 3, 0, -3 }, 
    { 10, 0, -10 }, 
    { 3, 0, -3 }};
  float normFactor = 1.f;

  PImage result = createImage(img.width, img.height, ALPHA);
  // clear the image
  for (int i = 0; i < img.width * img.height; i++) {
    result.pixels[i] = color(0);
  }
  float max=0;
  float[] buffer = new float[img.width * img.height];

  for (int x = 1; x < img.width - 1; ++x) {
    for (int y = 1; y < img.height - 1; ++y) {
      float sum_h = conv(hKernel, 3, img, normFactor, x, y);
      float sum_v = conv(vKernel, 3, img, normFactor, x, y);

      float sum = sqrt(pow(sum_h, 2) + pow(sum_v, 2));
      buffer[y * img.width + x] = sum;
      if (sum > max) {
        max = sum;
      }
    }
  }

  for (int y = 2; y < img.height - 2; y++) { // Skip top and bottom edges
    for (int x = 2; x < img.width - 2; x++) { // Skip left and right
      int val=(int) ((buffer[y * img.width + x] / max)*255);
      result.pixels[y * img.width + x]=color(val);
    }
  }
  return result;
}

float conv(float[][] kernel, int size, PImage img, float normFactor, int x, int y) {
  float sum = 0;
  for (int a = x - (size/2); a <= x + (size/2); a++) {
    for (int b = y - (size/2); b <= y + (size/2); b++) {
      sum += kernel[b -y + (size/2)][a -x + (size/2)] * brightness(img.pixels[b * img.width + a]);
    }
  }
  sum /= normFactor;
  return sum;
}