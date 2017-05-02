HScrollbar thresholdMin;
HScrollbar thresholdMax;
PImage img;
void settings() {
  size(1600, 600);
}

void setup() {
  img = loadImage("board1.jpg");
  thresholdMin = new HScrollbar(0, 580, 800, 20);
  thresholdMax = new HScrollbar(0, 550, 800, 20);
  //noLoop(); // no interactive behaviour: draw() will be called only once.
}

void draw() {
  image(img, 0, 0);//show image
  PImage img2 = img.copy();
  img2.loadPixels();

  for (int x = 0; x < img2.width; x++)
    for (int y = 0; y < img2.height; y++)
      if (y%2==0)
        img2.pixels[y*img2.width+x] = color(0, 0, 0);
  /* appying threshold
   img2 = threshold(img, 128); */
  img2 = hueing(img);
  img2.updatePixels();//update pixels
  image(img2, img.width, 0);
  
  thresholdMin.display();
  thresholdMin.update();
  thresholdMax.display();
  thresholdMax.update();
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