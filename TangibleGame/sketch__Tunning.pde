class Tunning extends PApplet {
  HScrollbar test;
  PGraphics tr;

  void settings() {
    size(600, input.height, P2D);
  }

  void setup() {
    tr = createGraphics(600, input.height, P2D);
    test = new HScrollbar(0, 0, 300, 20);
  }

  void draw() {
    // Image traitée
    output = threshold(scharr(gaussianBlur(thresholdHSB(input, Hmin, Hmax, Smin, Smax, Bmin, Bmax))), thrshld);
    // Blob detection not used because fuck you that's why.
    ArrayList<PVector> lines = hough(output, 6);

    background(interfaceColor);
    drawTunning();
    image(tr, 0, 0);
  }

  void drawTunning() {
    tr.beginDraw();
    {
      tr.background(interfaceColor);
      tr.image(input, 5, 5, input.width / 2.1, input.height / 2.1);
      tr.image(output, 5, input.height / 2.1 + 10, output.width / 2.1, output.height / 2.1);
    }
    tr.endDraw();
  }
}