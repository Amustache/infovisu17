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