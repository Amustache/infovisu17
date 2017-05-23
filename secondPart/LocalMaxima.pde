/*this wing is used merely as a place to write the algorithm
 to find the local maxima and avoid conflicts as Mathilde is 
 working on the Hough Detection.
 -> Not forget to put this code back in the HoughDetection class
 -> if you try and compile it, it won't work
 Thank you for your attention.
 */
//access accumulator as accumulator[phi + rDim + r] += 1
int bestC = 1;
ArrayList<Integer> bestCandidates = new ArrayList<Integer>();
int minVotes = 0;  //define that here to not have error messages
int regionSize = 10;

void localMaxima(int[] accumulator)
{ 
  for (int r = 0; r<rDim; ++r) {
    for (int phi = 0; phi < phiDim; ++phi) {

      int i = (phi + 1)*(rDim + 1) + r + 1; //find exact value in function of r and phi

      if (accumulator[i]>minVotes) {
        bestC = 0; //true
        
        for (int dphi = -regionSize/2; dphi < regionSize/2 + 1; ++dphi) {
          if !(accPhi + dPhi < 0 || accPhi + dPhi >= phiDim) break;
          
          for (int dr = -regionSize/2; dr < regionSize/2 + 1; ++dr) {
             if !(accR + dR < 0 || accR + dR >= rDim) break;

            int index = (phi + dphi + 1)*(rDim + 2) + r + dr + 1; //formule copiée
            if (accumulator[idx] < accumulator[index]) {
              bestC = 1; //false
              break;
            }
          }
          if(bestC == 1) break;
        }

        if (bestC == 0) {
          bestCandidates.add(i);
        }
      }
    }

    //this must be implemented BEFORE sorting the bestCandidates list