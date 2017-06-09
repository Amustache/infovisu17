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
class Hough {
  
  int minVotes;
   PImage edgeImg;
     PImage accImg;

   
   public Hough(PImage img, int minVotes) {
    edgeImg = img;
    this.minVotes = minVotes;
    accImg = createImage(0, 0, 0);
  }
  
    float discretizationStepsPhi = 0.06f; 
    float discretizationStepsR = 2.5f;
    // dimensions of the accumulator
    int phiDim = (int) (Math.PI / discretizationStepsPhi +1);
    //The max radius is the image diagonal, but it can be also negative
    int rDim  =(int) ((sqrt(edgeImg.width*edgeImg.width +
      edgeImg.height*edgeImg.height) * 2) / discretizationStepsR +1);
      
  ArrayList<PVector> hough(PImage edgeImg, int nLines) {

    ArrayList<Integer> bestCandidates = new ArrayList<Integer>();
    ArrayList<PVector> detectedLines = new ArrayList<PVector>();

    int[] accumulator = new int[(phiDim + 2) * (rDim + 2)];
    
     //sin cos table
    float[] tabSin = new float[phiDim];
    float[] tabCos = new float[phiDim];
    float ang = 0;
    float inverseR = 1.f / discretizationStepsR;
    for (int accPhi = 0; accPhi < phiDim; ang += discretizationStepsPhi, accPhi++) {
      tabSin[accPhi] = (float) (Math.sin(ang) * inverseR);
      tabCos[accPhi] = (float) (Math.cos(ang) * inverseR);
    }

    // definition of line candidates
    for (int y = 0; y < edgeImg.height; y++)
      for (int x = 0; x < edgeImg.width; x++)
        if (brightness(edgeImg.pixels[y * edgeImg.width + x]) != 0) {
          ang = 0;
          for (int phi = 0; phi < phiDim; ang += discretizationStepsPhi, phi++) {
            int indexPhi = Math.round(ang / discretizationStepsPhi + 1);
            float r =  (x * tabCos[phi] + y * tabSin[phi]);
            while (r < 0) r += (rDim - 1)/2;
            int indexR = Math.round(r) + (rDim - 1) / 2;
            accumulator[indexPhi * (rDim+2) + 1 + indexR] += 1;
          }
        }

    // choosing only the best candidates
    accImg = createImage(rDim + 2, phiDim + 2, ALPHA);
    for (int i = 0; i < accumulator.length; i++) {
      accImg.pixels[i] = color(min(255, accumulator[i]));
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
  }
}