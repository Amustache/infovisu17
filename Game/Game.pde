float speed = 1; // Speed multiplier
final float MIN_SPEED = 0.1, MAX_SPEED = 2.0; // Constraints on the speed

void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  noStroke();
}

void draw() {
  
}

// Control the speed multiplier with the mouse wheel
void mouseWheel(MouseEvent event) {
  float change = event.getCount();
  speed += change / 10;
  if(speed > MAX_SPEED) {
    speed = MAX_SPEED;
  }
  if(speed < MIN_SPEED) {
    speed = MIN_SPEED;
  }
  // Debug
  println(speed);
}