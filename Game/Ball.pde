final int radius = 50;
final float normalForce = 1;
final float mu = 0.01;
final float frictionMagnitude = normalForce * mu;

PVector velocity;
PVector location;
PVector gravity;
PVector friction;

void drawSphere() {
  checkEdges();
  translate(location.x, location.y -(boxThickness/2 + radius), 0);
  sphere(radius);
}

void updateBall() {

  location = new PVector(width/2, height/2, 0);
  velocity = new PVector(1, 1);

  gravity.x = sin(rZ) * GRAVITY;
  gravity.z = sin(rX) * GRAVITY;

  velocity.add(gravity);
  location.add(velocity);
  friction = velocity.get();
  friction.mult(-1);
  friction.normalize();
  friction.mult(frictionMagnitude);
}

void checkEdges() {
  if (location.x < centerX - boxWidth/2 || location.x > centerX + boxWidth/2) {
    velocity.x = -1 *velocity.x;
    if (location.y < centerY - boxHeight/2 || location.y > width) {
      velocity.y=-1*velocity.y;
    }
  }
}