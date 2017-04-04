/**
 * Define a mover (ball)
 */
class Mover {
  private int radius;// = 50;
  private PVector location, velocity, gravity, friction;

  public Mover(int radius_, PVector location_, PVector velocity_) {
    this.radius = radius_;
    this.location = location_;
    this.velocity = velocity_;
    this.gravity = new PVector(0, 1, 0);
    this.friction = new PVector(0, 0, 0);
  }

  void display() {
    pushMatrix();
    {
      //translate(location.x, -BOX_THICKNESS/2 - radius, location.z);
      stroke(238,169,144);
      lights();
      sphere(radius);
    }
    popMatrix();
  }

  void display2D() {
    pushMatrix();
    {
      stroke(102,84,94);
      fill(238,169,144);
      //translate(CENTER_X, CENTER_Y);
      ellipse(location.x, location.z, radius * 2, radius * 2);
    }
    popMatrix();
  }

  void update() {
    gravity.x = sin(rZ) * GRAVITY;
    gravity.z = -sin(rX) * GRAVITY;  

    friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(FRICTION_MAGNITUDE);

    velocity.add(gravity);
    velocity.add(friction);
    location.add(velocity);
  }

  void checkEdges() {
    if (location.x + RADIUS > BOX_WIDTH/2) {
      velocity.x = -velocity.x * ELASTICITY;
      location.x = BOX_WIDTH/2 - RADIUS;
    } else if (location.x - RADIUS < -BOX_WIDTH/2) {
      velocity.x = -velocity.x * ELASTICITY;
      location.x = -BOX_WIDTH/2 + RADIUS;
    }
    if (location.z + RADIUS > BOX_WIDTH/2) {
      velocity.z = -velocity.z * ELASTICITY;
      location.z = BOX_WIDTH/2 - RADIUS;
    } else if (location.z - RADIUS < -BOX_WIDTH/2) {
      velocity.z = -velocity.z * ELASTICITY;
      location.z = -BOX_WIDTH/2 + RADIUS;
    }
  }

  void checkCylinderCollision(ArrayList<Cylinder> cylinders) {
    //  V2 = V1 − 2(V1 · n)n
    for (Cylinder c : cylinders) {
      if (sqrt(pow((this.location.x - c.location.x), 2)) < radius + CYLINDER_BASE) {
        PVector norm = new PVector().normalize();
        // this.velocity = (this.velocity.sub((this.velocity.dot(norm))).mult(2));
      }
      if (sqrt(pow((this.location.z - c.location.z), 2)) < radius + CYLINDER_BASE) {
        PVector norm = new PVector().normalize();
        //   this.velocity = this.velocity.sub((this.velocity.dot(norm)).mult(2));
      }
    }
  }
}