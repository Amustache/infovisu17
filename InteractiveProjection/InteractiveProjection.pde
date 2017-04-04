float sc = 1;
final float SCALING = 0.01;
final float MIN_SCALE = 0.1;
final float MAX_SCALE = PI; // Because why not

float angleX = 0, angleY = 0;
final float ROTATING = 0.01;

void settings() {
  size(400, 400, P2D);
}

void setup() {
}

void keyStuff() {
  if (key == CODED && keyPressed) {
    switch(keyCode) {
    case UP:
      angleX -= ROTATING;
      break;
    case DOWN:
      angleX += ROTATING;
      break;
    case LEFT:
      angleY -= ROTATING;
      break;
    case RIGHT:
      angleY += ROTATING;
      break;
    default:
      break;
    }
  }
}

void mouseDragged() {
  if(pmouseY < mouseY && sc > MIN_SCALE) {
    sc -= SCALING;
  }
  
  if(pmouseY > mouseY && sc < MAX_SCALE) {
    sc += SCALING;
  }
}

void draw() {
  background(255, 255, 255);
  
  My3DPoint eye = new My3DPoint(-100, -100, -5000);
  My3DPoint origin = new My3DPoint(0, 0, 0); //The first vertex of your cuboid
  My3DBox input3DBox = new My3DBox(origin, 100, 150, 300);
  
  keyStuff();
  
  float[][] scaleBoxes = scaleMatrix(sc, sc, sc);
  float[][] rotateXBoxes = rotateXMatrix(angleX);
  float[][] rotateYBoxes = rotateYMatrix(angleY);
  
  input3DBox = transformBox(input3DBox, scaleBoxes);
  input3DBox = transformBox(input3DBox, rotateXBoxes);
  input3DBox = transformBox(input3DBox, rotateYBoxes);
  
  projectBox(eye, input3DBox).render();
}

class My2DPoint {
  float x;
  float y;
  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;
  My3DPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
  float x = (p.x - eye.x)*(-eye.z / (p.z - eye.z));
  float y = (p.y - eye.y)*(-eye.z / (p.z - eye.z));
  return new My2DPoint(x, y);
}

class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }
  
  void render() {
    strokeWeight(4); // Thickness

    stroke(0, 255, 0); // Green, Back
    line(s[5].x, s[5].y, s[6].x, s[6].y); // Up
    line(s[7].x, s[7].y, s[4].x, s[4].y); // Bottom+
    line(s[5].x, s[5].y, s[4].x, s[4].y); // Left
    line(s[7].x, s[7].y, s[6].x, s[6].y); // Right

    stroke(0, 0, 255); // Blue, Center
    line(s[5].x, s[5].y, s[1].x, s[1].y); // Up Left
    line(s[2].x, s[2].y, s[6].x, s[6].y); // Up Right
    line(s[0].x, s[0].y, s[4].x, s[4].y); // Bottom Left
    line(s[7].x, s[7].y, s[3].x, s[3].y); // Bottom Right

    stroke(255, 0, 0); // Red, Front
    line(s[2].x, s[2].y, s[1].x, s[1].y); // Up
    line(s[0].x, s[0].y, s[3].x, s[3].y); // Bottom
    line(s[0].x, s[0].y, s[1].x, s[1].y); // Left
    line(s[2].x, s[2].y, s[3].x, s[3].y); // Right
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ) {
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint[]{new My3DPoint(x, y+dimY, z+dimZ), 
      new My3DPoint(x, y, z+dimZ), 
      new My3DPoint(x+dimX, y, z+dimZ), 
      new My3DPoint(x+dimX, y+dimY, z+dimZ), 
      new My3DPoint(x, y+dimY, z), 
      origin, 
      new My3DPoint(x+dimX, y, z), 
      new My3DPoint(x+dimX, y+dimY, z)
    };
  }
  My3DBox(My3DPoint[] p) {
    this.p = p;
  }
}

// Takes a My3DBox and eye position and returns its projection.
My2DBox projectBox (My3DPoint eye, My3DBox box) {
  My2DPoint[] s = new My2DPoint[8];
  for (int i = 0; i < 8; ++i) {
    s[i] = projectPoint(eye, box.p[i]);
  }
  return new My2DBox(s);
}

// Takes a My3DPoint and adds a final coordinate of 1.
// Given
float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}

// Given
float[][] rotateXMatrix(float angle) {
  return(new float[][] {{1, 0, 0, 0}, 
    {0, cos(angle), sin(angle), 0}, 
    {0, -sin(angle), cos(angle), 0}, 
    {0, 0, 0, 1}});
}

float[][] rotateYMatrix(float angle) {
  return(new float[][] {
    {cos(angle), 0, sin(angle), 0}, 
    {0, 1, 0, 0}, 
    {-sin(angle), 0, cos(angle), 0}, 
    {0, 0, 0, 1}
    });
}

float[][] rotateZMatrix(float angle) {
  return(new float[][] {
    {cos(angle), -sin(angle), 0, 0}, 
    {sin(angle), cos(angle), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}
    });
}

float[][] scaleMatrix(float x, float y, float z) {
  return (new float[][] {
    {x, 0, 0, 0}, 
    {0, y, 0, 0}, 
    {0, 0, z, 0}, 
    {0, 0, 0, 1}
    });
}

float[][] translationMatrix(float x, float y, float z) {
  return (new float[][]{
    {1, 0, 0, x}, 
    {0, 1, 0, y}, 
    {0, 0, 1, z}, 
    {0, 0, 0, 1}
    });
}

// Dot product.
float[] matrixProduct(float[][] a, float[] b) {
  float[] result = {0, 0, 0, 0};

  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      result[i] += a[i][j] * b[j];
    }
  }

  return result;
}

// Given
My3DPoint euclidian3DPoint (float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
  My3DPoint[] oldPoints = box.p;
  My3DPoint[] newPoints = new My3DPoint[8];
  float[] current = new float[4];
  for (int i = 0; i < 8; ++i) {
    current[0] = oldPoints[i].x;
    current[1] = oldPoints[i].y;
    current[2] = oldPoints[i].z;
    current[3] = 1;

    newPoints[i] = euclidian3DPoint(matrixProduct(transformMatrix, current));
  }

  return new My3DBox(newPoints);
}