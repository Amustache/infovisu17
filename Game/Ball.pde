class Ball {

  int radius;
  PVector location;
  PVector velocity;

  PVector gravity = new PVector(0, 1, 0);
  PVector friction = new PVector(0, 0, 0);

  Ball(int radius, PVector startingVelocity, PVector startingLocation) {
    this.radius = radius;
    this.location = startingLocation;
    this.velocity = startingVelocity;
  }

  void display() {
    pushMatrix();
    translate(location.x, -boxThickness/2-radius, location.z);
    fill(0, 0, 0);
    lights();
    sphere(radius);
    popMatrix();
  }

  void display2D() {
    fill(0, 0, 0);
    ellipse(map(location.x, -450, 450, centerX - boxWidth / 2 + radius, centerX + boxWidth / 2 - radius), map(location.z, -450, 450, centerY - boxHeight / 2 + radius, centerY + boxHeight / 2 - radius), radius * 2, radius * 2);
    print(location.x+"\n");
  }

  void update() {
    gravity.x = sin(rZ) * GRAVITY;
    gravity.z = -sin(rX) * GRAVITY;

    friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);

    velocity.add(gravity);
    velocity.add(friction);
    location.add(velocity);
  }

  void checkEdges() {
    if (location.x + RADIUS > boxWidth/2) {
      velocity.x = -velocity.x * elasticity;
      location.x = boxWidth/2 - RADIUS;
    } else if (location.x - RADIUS < -boxWidth/2) {
      velocity.x = -velocity.x * elasticity;
      location.x = -boxWidth/2 + RADIUS;
    }
    if (location.z + RADIUS > boxWidth/2) {
      velocity.z = -velocity.z * elasticity;
      location.z = boxWidth/2 - RADIUS;
    } else if (location.z - RADIUS < -boxWidth/2) {
      velocity.z = -velocity.z * elasticity;
      location.z = -boxWidth/2 + RADIUS;
    }
  }

  void checkCylinderCollision(ArrayList<Cylinder> cylinders) {
    //  V2 = V1 − 2(V1 · n)n
    for (Cylinder c : cylinders) {
      if (sqrt(pow((this.location.x - c.location.x), 2)) < radius + c.cylinderBaseSize) {
        PVector norm = new PVector().normalize();
        // this.velocity = (this.velocity.sub((this.velocity.dot(norm))).mult(2));
      }
      if (sqrt(pow((this.location.z - c.location.z), 2)) < radius + c.cylinderBaseSize) {
        PVector norm = new PVector().normalize();
        //   this.velocity = this.velocity.sub((this.velocity.dot(norm)).mult(2));
      }
    }
  }
}