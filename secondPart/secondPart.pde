HScrollbar hsmax, hsmin;
PGraphics bande;
PGraphics scroll;
PImage img;
void settings() {
  size(1600, 600);
}

void setup() {
  img = loadImage("board1.jpg");
  bande = createGraphics(100, 100, P2D);
  scroll = createGraphics(100, 100, P2D);
  hs = new HScrollbar(0, 0, 300, 20);
  noLoop(); // no interactive behaviour: draw() will be called only once.
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