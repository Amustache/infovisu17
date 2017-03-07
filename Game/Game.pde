float speed = 1; // Speed multiplier
float depth = 2000;
final float MIN_SPEED = 0.1, MAX_SPEED = 2.0; // Constraints on the speed
final float MIN_ANGLE = -PI/3, MAX_ANGLE = PI/3;
//float angleX = 0, angleY = 0;
float origineY = 605;
float origineX = 605;

void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  noStroke();
}

void draw() {

  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(100, 100, 100);
  background(230);


  fill(255);


  camera(width/2, height/2, depth, 250, 250, 0, 0, 1, 0);

  translate(width/2, height/2, 0);
  float rx = map(-(mouseY - origineY), 0, height, 0, PI/3);
  float rz = map(-(mouseX - origineX), 0, height, 0, PI/3);
  rotate(rz);
  rotateX(rx);
  box(1000, 10, 1000);
  println(mouseX);
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      depth -= 50;
    } else if (keyCode == DOWN) {
      depth += 50;
    }
  }
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