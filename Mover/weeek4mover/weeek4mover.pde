
Mover mover;
void settings() {
size(800, 200);
}
void setup() {
mover = new Mover();
}
void draw() {
background(255);
mover.update();
mover.checkEdges();
mover.display();
}

class Mover {
PVector location;
PVector velocity;
PVector gravity = new PVector(0,1);
Mover() {
location = new PVector(width/2, height/2);
velocity = new PVector(5, 12);
}
void update() {
location.add(velocity);
}
void display() {
stroke(0);
strokeWeight(2);
fill(127);
ellipse(location.x, location.y, 48, 48);
}
void checkEdges() {
if ((location.x > width) || (location.x < 0)) {
velocity.x = velocity.x * -1;
}
if ((location.y > height) || (location.y < 0)) {
velocity.y = velocity.y * -1;
}
}
}