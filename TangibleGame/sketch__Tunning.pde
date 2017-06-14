class Tunning extends PApplet {
  void settings() {
    size(600, input.height, P2D);
  }

  void setup() {
  }

  void draw() {
    background(bgColor);
    
    if (cam.available()) {
      cam.read();
    }
    input = cam.get();

    // Valeurs empiriques
    Hmin = 95;
    Hmax = 115;
    Smin = 95;
    Smax = 255;
    Bmin = 0;
    Bmax = 151;
    thrshld = 100;

    // Image traitée
    output = threshold(scharr(gaussianBlur(findConnectedComponents(thresholdHSB(input, Hmin, Hmax, Smin, Smax, Bmin, Bmax), true))), thrshld);

    ArrayList<PVector> lines = hough(output, 4);

    List<PVector> quadz = qg.findBestQuad(lines, output.width, output.height, output.width * output.height, (output.width * output.height) / 4, false);

    tg = new TwoDThreeD(width, height, 24); // Not sure of the framerate

    if (quadz.size() > 0) {
      PVector rot = tg.get3DRotations(quadz);
    }
    
    image(input, 0, 0, input.width / 2, input.height / 2);
    image(output, 0, input.height / 2, output.width / 2, output.height / 2);
  }
}