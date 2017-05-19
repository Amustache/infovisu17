import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

class BlobDetection {
  PImage findConnectedComponents(PImage input, boolean onlyBiggest) {
    PImage result = null;
    // First pass: label the pixels and store labels’ equivalences
    int [] labels= new int [input.width*input.height];
    for (int i = 0; i < img.width * img.height; ++i) {
      labels[i] = 0;
    }
    List<TreeSet<Integer>> labelsEquivalences= new ArrayList<TreeSet<Integer>>();

    int currentLabel=1;
    labelsEquivalences.add(new TreeSet<Integer>());
    labelsEquivalences.get(currentLabel - 1).add(currentLabel);

    // TODO!
    for (int i = 0; i < img.width * img.height; ++i) {
      if (brightness(color(img.pixels[i])) > 128) {
        List<Integer> neigh = new ArrayList<Integer>();
        
        int W = !(i % img.height == 0) ? (i - 1) : (-1), 
          NW = !(i % img.height == 0) && !(i - img.height < 0) ? (i - img.height - 1) : (-1), 
          NN = !(i - img.height < 0) ? (i - img.height) : (-1), 
          NE = !(i + 1 % img.height == 0) && !(i - img.height < 0) ? (i - img.height + 1) : (-1);
        
        if (W > -1 && labels[W] > 0) {
          neigh.add(labels[W]);
        }

        if (NW > -1 && labels[NW] > 0) {
          neigh.add(labels[NW]);
        }

        if (NN > -1 && labels[NN] > 0) {
          neigh.add(labels[NN]);
        }

        if (NE > -1 && labels[NE] > 0) {
          neigh.add(labels[NE]);
        }
        
        if(neigh.size() > 0) { // If some of the four neighbour pixels have a label
          for(int n : neigh) {
            labels[i] = Math.min(labels[i], n);
          }
          for(int n : neigh) {
            labelsEquivalences.get(labels[i] - 1).add(n);
          }
        } else { // else new label
          ++currentLabel;
          labels[i] = currentLabel;
          labelsEquivalences.add(new TreeSet<Integer>());
          labelsEquivalences.get(currentLabel - 1).add(currentLabel);
        }
      }
    }

    // Second pass: re-label the pixels by their equivalent class
    // if onlyBiggest==true, count the number of pixels for each label

    // TODO!


    // Finally,
    // if onlyBiggest==false, output an image with each blob colored in one uniform color
    // if onlyBiggest==true, output an image with the biggest blob colored in white and the others in black

    // TODO!

    return result;
  }
}
/*PImage findConnectedComponents(PImage input, boolean onlyBiggest) {
 PImage result = createImage(img.width, img.height, RGB);
 
 // First pass: label the pixels and store labels’ equivalences
 int [] labels= new int [input.width*input.height];
 List<TreeSet<Integer>> labelsEquivalences= new ArrayList<TreeSet<Integer>>();
 
 int currentLabel=1;
 
 // TODO!
 for (int i = 0; i < img.width * img.height; ++i) { // For each pixel
 if (img.pixels[i] == color(255)) { // Which is not background
 int minLabel = Integer.MAX_VALUE;
 boolean sameLabel = true;
 
 // If !(out of bound) then value else -1
 int W = !(i % img.height == 0) ? (i - 1) : (-1), 
 NW = !(i % img.height == 0) && !(i - img.height < 0) ? (i - img.height - 1) : (-1), 
 NN = !(i - img.height < 0) ? (i - img.height) : (-1), 
 NE = !(i + 1 % img.height == 0) && !(i - img.height < 0) ? (i - img.height + 1) : (-1);
 
 if (W > -1 && labels[W] > 0) {
 minLabel = Math.min(minLabel, labels[W]);
 }
 
 if (NW > -1 && labels[NW] > 0) {
 minLabel = Math.min(minLabel, labels[NW]);
 }
 
 if (NN > -1 && labels[NN] > 0) {
 minLabel = Math.min(minLabel, labels[NN]);
 }
 
 if (NE > -1 && labels[NE] > 0) {
 minLabel = Math.min(minLabel, labels[NE]);
 }
 
 // If no match, create new label
 minLabel = Math.min(minLabel, currentLabel + 1);
 if (minLabel == currentLabel + 1) {
 ++currentLabel;
 }
 } else {
 labels[i] = 0; // Not a blob
 }
 }
 
 // Second pass: re-label the pixels by their equivalent class
 // if onlyBiggest==true, count the number of pixels for each label
 
 // TODO!
 for (int i = 0; i < img.width * img.height; ++i) { // For each pixel
 if(labels[i] > 0) {
 labels[i] = labelsEquivalences.get(0).first();
 }
 }
 
 // Finally,
 // if onlyBiggest==false, output an image with each blob colored in one uniform color  
 // if onlyBiggest==true, output an image with the biggest blob colored in white and the others in black
 
 // TODO!
 
 return result;
 }
 }