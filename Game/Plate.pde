// Box parameters.
final int boxWidth = 1000;
final int boxHeight = 1000;
final int boxThickness = 40;

void drawPlate() {
  translate(centerX, centerY);
  rotateBox();
  box(boxWidth, boxThickness, boxHeight);
  fill(255);
  stroke(150, 150, 0);
}

/* Control inclinaison with mouse */
void rotateBox() {
  // float rX = map(-(mouseY - origineY), 0, height, 0, PI/3);  
  // float rZ = map(-(mouseX - origineX), 0, height, 0, PI/3);
  rotateX(rX);
  rotateZ(rZ);
} 