/*import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


class Hough {



  List<PVector> hough() {


    float discretizationStepsPhi = 0.06f; 
    float discretizationStepsR = 2.5f;
    // dimensions of the accumulator
    int phiDim = (int) (Math.PI / discretizationStepsPhi +1);
    //The max radius is the image diagonal, but it can be also negative
    int rDim  =(int) ((sqrt(edgeImg.width*edgeImg.width +
      edgeImg.height*edgeImg.height) * 2) / discretizationStepsR +1);

    // our accumulator
    int[] accumulator = new int[(phiDim + 2) * (rDim + 2)];


   

    // Fill the accumulator: on edge points (ie, white pixels of the edge
    // image), store all possible (r, phi) pairs describing lines going
    // through the point.
    for (int y = 0; y < edgeImg.height; y++) {
      for (int x = 0; x < edgeImg.width; x++) {
        // Are we on an edge?
        if (brightness(edgeImg.pixels[y * edgeImg.width + x]) != 0) {
          // ...determine here all the lines (r, phi) passing through
          // pixel (x,y), convert (r,phi) to coordinates in the
          // accumulator, and increment accordingly the accumulator.
          // Be careful: r may be negative, so you may want to center onto
          // the accumulator: r += rDim / 2
          for (int phiIdx = 0; phiIdx < phiDim; phiIdx++) {
            float phi = phiIdx * discretizationStepsPhi;
            int accPhi = Math.round(phi / discretizationStepsPhi);

            float r = x * tabCos[accPhi] +  y * tabSin[accPhi];
            r += (rDim) / 2.f;

            int idx = Math.round(r + (phiIdx + 1) * (rDim + 2) + 1);
           // System.out.print(idx);
            //System.out.print(" ");
            accumulator[idx] += 1;
          }
        }
      }
    }


    accImg = createImage(rDim + 2, phiDim + 2, ALPHA);
    for (int i = 0; i < accumulator.length; i++) {
      accImg.pixels[i] = color(Math.min(255, accumulator[i]));
    }
    // You may want to resize the accumulator to make it easier to see:
    accImg.resize(400, 400);
    accImg.updatePixels();

    // Choose best lines
    ArrayList<Integer> bestCandidates = new ArrayList<Integer>();

    localMaxima(accumulator, bestCandidates, phiDim, rDim);


    Collections.sort(bestCandidates, new comparator(accumulator));

    ArrayList<PVector> lines = new ArrayList<PVector>();

    for (int i = 0; i < 6 && i < bestCandidates.size(); i++) {
      int idx = bestCandidates.get(i);
      // first, compute back the (r, phi) polar coordinates:
      int accPhi = (int) (idx / (rDim + 2)) - 1;
      int accR = idx - (accPhi + 1) * (rDim + 2) - 1;
      float r = (accR - (rDim - 1) * 0.5f) * discretizationStepsR;
      float phi = accPhi * discretizationStepsPhi;

      lines.add(new PVector(r, phi));
    }

    return lines;
  }

  public PImage getAccImg() {
    return accImg;
  }

  public ArrayList<PVector> getIntersections() {
    List<PVector> lines = hough();
    ArrayList<PVector> intersections = new ArrayList<PVector>();

    for (int i = 0; i < lines.size() - 1; i++) {
      PVector line1 = lines.get(i);

      for (int j = i + 1; j < lines.size(); j++) {
        PVector line2 = lines.get(j);

        float d = PApplet.cos(line2.y) * PApplet.sin(line1.y) - PApplet.cos(line1.y) * PApplet.sin(line2.y);
        float x = (line2.x * PApplet.sin(line1.y) - line1.x * PApplet.sin(line2.y)) / d;
        float y = (-line2.x * PApplet.cos(line1.y) + line1.x * PApplet.cos(line2.y)) / d;

        // draw the intersection
        fill(255, 128, 0);
        ellipse(x, y, 10, 10);
      }
    }
    return intersections;
  }


  //access accumulator as accumulator[phi + rDim + r] += 1
  int bestC = 1;
  int regionSize = 10;

  void localMaxima(int[] accumulator, ArrayList<Integer> bestCandidates, int phiDim, int rDim)
  { 
    for (int r = 0; r<rDim; ++r) {
      for (int phi = 0; phi < phiDim; ++phi) {

        int i = (phi + 1)*(rDim + 1) + r + 1; //find exact value in function of r and phi

        if (accumulator[i]>minVotes) {
          bestC = 0; //true

          for (int dphi = -regionSize/2; dphi < regionSize/2 + 1; ++dphi) {
            if (!(phi + dphi < 0 || phi + dphi >= phiDim)) break;

            for (int dr = -regionSize/2; dr < regionSize/2 + 1; ++dr) {
              if (!(r + dr < 0 || r + dr >= rDim)) break;

              int index = (phi + dphi + 1)*(rDim + 2) + r + dr + 1; //formule copiée
              if (accumulator[index] < accumulator[index]) {
                bestC = 1; //false
                break;
              }
            }
            if (bestC == 1) break;
          }

          if (bestC == 0) {
            bestCandidates.add(i);
          }
        }
      }
    }
  }
}

class comparator implements Comparator<Integer> {
  int[] accumulator;
  comparator(int[] accumulator) {
    this.accumulator = accumulator;
  }

  int compare(Integer l1, Integer l2) {
    if (accumulator[l1] > accumulator[l2]
      || (accumulator[l1] == accumulator[l2] && l1 < l2)) return -1;
    return 1;
  }
}

class HoughComparator implements java.util.Comparator<Integer> {
  int[] accumulator;

  public HoughComparator(int[] accumulator) {
    this.accumulator = accumulator;
  }

  @Override
    public int compare(Integer l1, Integer l2) {
    if (accumulator[l1] > accumulator[l2] || (accumulator[l1] == accumulator[l2] && l1 < l2)) return -1;
    return 1;
  }
}

ArrayList<PVector> hough(PImage edgeImg, int nLines) {
  
  ArrayList<Integer> bestCandidates = new ArrayList<Integer>();
  ArrayList<PVector> detectedLines = new ArrayList<PVector>();

  // dimensions of the accumulator
  int rDim = (int) (((edgeImg.width + edgeImg.height) * 2 + 1) / discretizationStepsR);
  int[] accumulator = new int[(phiDim + 2) * (rDim + 2)];

  // definition of line candidates
  for(int y = 0; y < edgeImg.height; y++)
    for(int x = 0; x < edgeImg.width; x++)
      if(brightness(edgeImg.pixels[y * edgeImg.width + x]) != 0){
        ang = 0;
        for(int phi = 0; phi < phiDim; ang += discretizationStepsPhi, phi++){
          int indexPhi = Math.round(ang / discretizationStepsPhi + 1);
          float r =  (x * tabCos[phi] + y * tabSin[phi]);
          while(r < 0) r += (rDim - 1)/2;
          int indexR = Math.round(r) + (rDim - 1) / 2;
          accumulator[indexPhi * (rDim+2) + 1 + indexR] += 1;
        }
      }

  // choosing only the best candidates
  houghImg = createImage(rDim + 2, phiDim + 2, ALPHA);
  for (int i = 0; i < accumulator.length; i++) {
    houghImg.pixels[i] = color(min(255, accumulator[i]));
  }

  // size of the region we search for a local maximum
  int neighbourhood = 12;
  // only search around lines with more that this amount of votes
  int minVotes = 130;
  for (int accR = 0; accR < rDim; accR++) {
    for (int accPhi = 0; accPhi < phiDim; accPhi++) {
      // compute current index in the accumulator
      int idx = (accPhi + 1) * (rDim + 2) + accR + 1;
      if (accumulator[idx] > minVotes) {
        boolean bestCandidate=true;
        // iterate over the neighbourhood
        for (int dPhi=-neighbourhood/2; dPhi < neighbourhood/2+1; dPhi++) {
          // check we are not outside the image
          if (accPhi+dPhi < 0 || accPhi+dPhi >= phiDim) continue;
          for (int dR=-neighbourhood/2; dR < neighbourhood/2 +1; dR++) {
            // check we are not outside the image
            if (accR+dR < 0 || accR+dR >= rDim) continue;
            int neighbourIdx = (accPhi + dPhi + 1) * (rDim + 2) + accR + dR + 1;
            if (accumulator[idx] < accumulator[neighbourIdx]) {
              // the current idx is not a local maximum!
              bestCandidate=false;
              break;
            }
          }
          if (!bestCandidate) break;
        }
        if (bestCandidate) {
          // the current idx *is* a local maximum
          bestCandidates.add(idx);
        }
      }
    }
  }

  Collections.sort(bestCandidates, new HoughComparator(accumulator));

  // plotting the lines on the picture
  for (int idx = 0; idx < min(nLines, bestCandidates.size()); idx++) {
    int accPhi = (int) (bestCandidates.get(idx) / (rDim + 2)) - 1;
    int accR = bestCandidates.get(idx) - (accPhi + 1) * (rDim + 2) - 1;
    float r = (accR - (rDim - 1) * 0.5f) * discretizationStepsR;
    float phi = accPhi * discretizationStepsPhi;

    detectedLines.add(new PVector(r, phi));
  }
  return detectedLines;
}*/