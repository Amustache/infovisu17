float speed = 1; // Speed multiplier
float depth = 2000;
final float MIN_SPEED = 0.1, MAX_SPEED = 2.0; // Constraints on the speed
final float MIN_ANGLE = -PI/3, MAX_ANGLE = PI/3;
//float angleX = 0, angleY = 0;
int boxWidth = 1000;
int boxHeight = 1000;
int boxThickness = 40;
float origineY = height + boxThickness /2 ;
float origineX = width/2;

void settings() {
  size(1000, 1000, P3D);
}

void setup() {
}

void draw() {

  lightSet();
  background(230);
  fill(255);
  stroke(150, 150, 0);
  camera(width/2, height/2, depth, width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2);
  rotatebox();
  box(boxWidth, boxThickness, boxHeight);
}
//Zoom with UP DOWN
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      depth -= 50;
    } else if (keyCode == DOWN) {
      depth += 50;
    }
  }
}

//Settings for light
void lightSet() {
  //directionalLight(150, 150, 150, 0, -1, 0);
  //ambientLight(100, 50, 0);
  //ambient(1);


  directionalLight(50, 50, 50, 0, 0, -1);
  ambientLight(153, 102, 0);
  ambient(51, 26, 0);
}

//Control inclinaison with mouse
void rotatebox() {
  float rx = map(-(mouseY - origineY), 0, height, 0, PI/3);
  float rz = map(-(mouseX - origineX), 0, height, 0, PI/3);
  rotate(rz);
  rotateX(rx);
}

// Control the speed multiplier with the mouse wheel
void mouseWheel(MouseEvent event) {
  float change = event.getCount();
  speed += change / 10;
  if (speed > MAX_SPEED) {
    speed = MAX_SPEED;
  }
  if (speed < MIN_SPEED) {
    speed = MIN_SPEED;
  }
  // Debug
  //println(speed);
}

//float mapToAngle(int mX, int mY) {}