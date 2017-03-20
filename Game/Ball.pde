final int radius = 50;
final float normalForce = 1;
final float mu = 0.01;
final float frictionMagnitude = normalForce * mu;

PVector velocity = new PVector(0,0,0);
PVector location = new PVector(0,0,0);
PVector gravity = new PVector(0,0,0);
PVector friction = new PVector(0,0,0);

void drawSphere() {
  updateBall();
  checkEdges();
  translate(location.x, location.y -(boxThickness/2 + radius), 0);
  sphere(radius);
}

void updateBall() {

  gravity = new PVector(sin(rZ)*GRAVITY, 0, sin(rX)*GRAVITY);
  location = new PVector(width/2, height/2, 0);
  velocity = new PVector(1, 1, 1);
  friction = ((velocity.get().mult(-1)).normalize()).mult(frictionMagnitude);


  velocity.add(gravity);
  location.add(velocity);

}

void checkEdges() {
  if (location.x < centerX - boxWidth/2 || location.x > centerX + boxWidth/2) {
    velocity.x = -1 *velocity.x;
    if (location.y < centerY - boxHeight/2 || location.y > width) {
      velocity.y=-1*velocity.y;
    }
  }
}