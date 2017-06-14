import java.util.*;

PImage findConnectedComponents(PImage input, boolean onlyBiggest) {
  // First pass: label the pixels and store labels’ equivalences
  onlyBiggest = true;
  int [] labels= new int [input.width*input.height];
  List<TreeSet<Integer>> labelsEquivalences= new ArrayList<TreeSet<Integer>>();

  int currentLabel = 1;
  for (int x = 0; x < input.width; x++) {
    for (int y = 0; y < input.height; y++) {
      // if the pixel is in the foreground   
      if (brightness(input.pixels[y * input.width + x]) !=0) {
        TreeSet<Integer> neighbours = new TreeSet<Integer>();
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {             
            // avoid taking pixels out of bound
            if ((x+i) >= 0 && (y+j) >= 0 && (x+i) < input.width && (y+j) < input.height) {
              if (brightness(input.pixels[(y + j) * input.width + x + i]) == brightness(input.pixels[y * input.width + x])) {                    
                // add neighbours if pixel/label value is the same if label = 0, means that the pixel is unvisited
                if (labels[(y + j) * input.width + x + i] != 0) {
                  neighbours.add(labels[(y + j) * input.width + x + i]);
                }
              }
            }
          }
        }
        if (neighbours.isEmpty()) {
          labels[y * input.width + x] = currentLabel;
          currentLabel += 1;
        } else {
          // Smallest label is the first element of TreeSet
          labels[y * input.width + x] = neighbours.first();
          if (neighbours.size() > 1) {
            labelsEquivalences.add(neighbours);
          }
        }
      }
    }
  }

  //second pass
  int count [] = new int [max(labels)];
  for (int x = 0; x < input.width; x++) {
    for (int y = 0; y < input.height; y++) {
      if (brightness(input.pixels[y * input.width + x]) !=0) {
        for (int i = 0; i < labelsEquivalences.size(); i++) {
          if (labelsEquivalences.get(i).contains(labels[y * input.width + x])) {
            labels[y * input.width + x] = labelsEquivalences.get(i).first();
            count[labelsEquivalences.get(i).first() -1] += 1;
          }
        }
      }
    }
  }
  if (onlyBiggest) {
    int temp = 0;
    for (int label = 0; label < max(labels); label++) {
      if (count[label] > count[temp]) {
        temp = label;
      }
    }
    int biggerLabel = temp + 1;
    PImage result = createImage(input.width, input.height, RGB);
    for (int i = 0; i < input.width * input.height; i++) {
      if (labels[i] == biggerLabel) {
        result.pixels[i] = color(255, 255, 255);
      } else {
        result.pixels[i] = color(0, 0, 0);
      }
    }
    return result;
  } else {

    PImage result = createImage(input.width, input.height, RGB);
    for (int i = 0; i < input.width * input.height; i++) {
      if (labels[i] == 0) {
        result.pixels[i] = color(0, 0, 0);
      } else {
        result.pixels[i] = color(100, 0, 0);
      }
    }
    return result;
  }
}