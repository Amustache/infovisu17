import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

class BlobDetection {
  PImage findConnectedComponents(PImage input, boolean onlyBiggest) {
    PImage result = createImage(input.width, input.height, RGB);
    // First pass: label the pixels and store labels’ equivalences
    int [] labels= new int [input.width*input.height];
    for (int i = 0; i < img.width * img.height; ++i) {
      labels[i] = 0;
    }
    List<TreeSet<Integer>> labelsEquivalences= new ArrayList<TreeSet<Integer>>(); // This be the equivalences

    int currentLabel=1;
    labelsEquivalences.add(new TreeSet<Integer>());
    labelsEquivalences.get(currentLabel - 1).add(currentLabel); // Add the first label

    // TODO!
    for (int i = 0; i < img.width * img.height; ++i) {
      if (brightness(color(img.pixels[i])) > 128) {
        List<Integer> neigh = new ArrayList<Integer>();

        int W = !(i % img.height == 0) ? (i - 1) : (-1), // Basically, "is this shit out of bound?"
          NW = !(i % img.height == 0) && !(i - img.height < 0) ? (i - img.height - 1) : (-1), 
          NN = !(i - img.height < 0) ? (i - img.height) : (-1), 
          NE = !((i + 1) % img.height == 0) && !(i - img.height < 0) ? (i - img.height + 1) : (-1);

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

        if (neigh.size() > 0) { // If some of the four neighbour pixels have a label
          labels[i] = neigh.get(0);
          ArrayList<Integer> temp = new ArrayList<Integer>();
          for (int n : neigh) {
            labels[i] = Math.min(labels[i], n);
            temp.addAll(labelsEquivalences.get(n - 1));
          }
          for (int n : neigh) {
            //labelsEquivalences.get(labels[i] - 1).addAll(labelsEquivalences.get(n - 1));
            //labelsEquivalences.get(n - 1).addAll(labelsEquivalences.get(n - 1));
            labelsEquivalences.get(n - 1).addAll(temp);
          }
          labelsEquivalences.get(labels[i] - 1).addAll(temp);
        } else { // else new label
          ++currentLabel;
          labels[i] = currentLabel;
          labelsEquivalences.add(new TreeSet<Integer>());
          labelsEquivalences.get(currentLabel - 1).add(currentLabel);
        }
      }
    }

    // println(labelsEquivalences); // debug

    // Second pass: re-label the pixels by their equivalent class
    // if onlyBiggest==true, count the number of pixels for each label

    // TODO!
    List<Integer> nbPixels = new ArrayList<Integer>(); // Count the number of pixels per blob
    for (int i = 0; i < labelsEquivalences.size(); ++i) {
      nbPixels.add(0);
    }

    for (int i = 0; i < img.width * img.height; ++i) { // Relabel the shits
      if (labels[i] > 0) {
        labels[i] = labelsEquivalences.get(labels[i] - 1).first();
        if (onlyBiggest) {
          nbPixels.set(labels[i] - 1, nbPixels.get(labels[i] - 1) + 1);
        }
      }
    }

    // println(nbPixels); // debug

    // Finally,
    // if onlyBiggest==false, output an image with each blob colored in one uniform color
    // if onlyBiggest==true, output an image with the biggest blob colored in white and the others in black

    // TODO!

    int maxBlob = -1, maxSize = -1;
    if (onlyBiggest) {
      for (int i = 0; i < nbPixels.size(); ++i) {
        if (maxSize < nbPixels.get(i)) {
          maxBlob = i + 1;
          maxSize = nbPixels.get(i);
        }
      }
    }

    // println(maxBlob); // debug
    // println(maxSize);

    for (int i = 0; i < img.width * img.height; ++i) {
      if (onlyBiggest) {
        if (labels[i] == maxBlob) {
          result.pixels[i] = color(255);
        } else {
          result.pixels[i] = color(0);
        }
      } else {
        if (labels[i] > 0) {
          int hash = (Integer.toString(labels[i]) + "Tant va la cruche à l'eau qu'à la fin tu me les brises.").hashCode();
          result.pixels[i] = color((hash & 0xFF0000) >> 16, (hash & 0x00FF00) >> 8, hash & 0x0000FF);
        } else {
          result.pixels[i] = color(0);
        }
      }
    }

    return result;
  }
}