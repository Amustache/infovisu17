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

    ArrayList<PVector> quadz = qg.findBestQuad(lines, output.width, output.height, output.width * output.height, (output.width * output.height) / 4, false);
    //qg.drawQuads(quadz);


    if (quadz.size() > 0) {
      dTt = new TwoDThreeD(width, height, 24); // Not sure of the framerate
      List<PVector> nullQG = new ArrayList(Arrays.asList(zero3D, zero3D, zero3D, zero3D));

      for (int i = 0; i < quadz.size(); i++) {
        nullQG.set(i, new PVector(quadz.get(i).x, quadz.get(i).y, 1));
      }

      PVector rot = dTt.get3DRotations(nullQG);
      PVector rho = new PVector(0, 0, 0);
      /*rho.x = rX - oldP.x;
      rho.y = r.y - oldP.y;
      rho.z = r.z - oldP.z;

      oldP = new PVector(rX, 0, rZ);
      rX = rot.x;
      rZ = rot.z;*/ // Doesn't work
    }

    image(input, 0, 0, input.width / 2, input.height / 2);
    image(output, 0, input.height / 2, output.width / 2, output.height / 2);
  }
}