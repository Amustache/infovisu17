class Ball {
  
  int radius;
  PVector location;
  PVector velocity;

  PVector gravity = new PVector(1, 0, 0);
  PVector friction = new PVector(0, 0, 0);

  Ball(int radius, PVector startingVelocity, PVector startingLocation) {
    this.radius = radius;
    this.location = startingLocation;
    this.velocity = startingVelocity;
  }
  
  void draw() {
    update();
    checkEdges();
    translate(location.x, location.y -(boxThickness/2 + radius), 0);
    sphere(radius);
  }

  void update() {
    gravity = new PVector(sin(rZ)*GRAVITY, 0, sin(rX)*GRAVITY);
    location = new PVector(centerX, centerY-boxThickness, 0);
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
}