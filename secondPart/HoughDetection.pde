/*import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import processing.core.*;

public final class Hough {

  PImage edgeImg;
  int minVotes;
  PImage accImg;
  float discretizationStepsPhi = 0.06f; 
  float discretizationStepsR = 2.5f;
  // dimensions of the accumulator
  int phiDim = (int) (Math.PI / discretizationStepsPhi +1);
  //The max radius is the image diagonal, but it can be also negative
  int rDim;


  public Hough(PImage img, int minVotes) {
    edgeImg = img;
    this.minVotes = minVotes;
    accImg = createImage(0, 0, 0);
    rDim = (int) ((sqrt(edgeImg.width*edgeImg.width +
    edgeImg.height*edgeImg.height) * 2) / discretizationStepsR +1);
  }

  List<PVector> hough(PImage edgeImg) {
    // our accumulator
    int[] accumulator = new int[phiDim * rDim];

    //sin cos table
    float[] tabSin = new float[phiDim];
    float[] tabCos = new float[phiDim];

    float ang = 0;
    float inverseR = 1.f / discretizationStepsR;

    for (int accPhi = 0; accPhi < phiDim; ang += discretizationStepsPhi, accPhi++) {
      tabSin[accPhi] = (float) (Math.sin(ang) * inverseR);
      tabCos[accPhi] = (float) (Math.cos(ang) * inverseR);
    }

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
            r += (rDim - 1.f) / 2.f;

            int idx = Math.round(r + (phiIdx + 1) * (rDim + 2) + 1);

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

    ArrayList<PVector> lines = new ArrayList<PVector>();
    for (int idx = 0; idx < accumulator.length; idx++) {
      if (accumulator[idx] > minVotes) {
        // first, compute back the (r, phi) polar coordinates:
        int accPhi = (int) (idx / (rDim));
        int accR = idx - (accPhi) * (rDim);
        float r = (accR - (rDim) * 0.5f) * discretizationStepsR;
        float phi = accPhi * discretizationStepsPhi;
        lines.add(new PVector(r, phi));
      }
    }
    for (int idx = 0; idx < lines.size(); idx++) {
      int accPhi = (int) (idx / (rDim + 2)) - 1;
      int accR = idx - (accPhi + 1) * (rDim + 2) - 1;
      float r = (accR - (rDim - 1) * 0.5f) * discretizationStepsR;
      float phi = accPhi * discretizationStepsPhi;
      PVector line = lines.get(idx);
      // Cartesian equation of a line: y = ax + b
      // in polar, y = (-cos(phi)/sin(phi))x + (r/sin(phi))
      // => y = 0 : x = r / cos(phi)
      // => x = 0 : y = r / sin(phi)
      // compute the intersection of this line with the 4 borders of
      // the image
      int x0 = 0;
      int y0 = (int) (r / sin(phi));
      int x1 = (int) (r / cos(phi));
      int y1 = 0;
      int x2 = edgeImg.width;
      int y2 = (int) (-cos(phi) / sin(phi) * x2 + r / sin(phi));
      int y3 = edgeImg.width;
      int x3 = (int) (-(y3 - r / sin(phi)) * (sin(phi) / cos(phi)));
      // Finally, plot the lines
      stroke(204, 102, 0);
      if (y0 > 0) {
        if (x1 > 0)
          line(x0, y0, x1, y1);
        else if (y2 > 0)
          line(x0, y0, x2, y2);
        else
          line(x0, y0, x3, y3);
      } else {
        if (x1 > 0) {
          if (y2 > 0)
            line(x1, y1, x2, y2);
          else
            line(x1, y1, x3, y3);
        } else
          line(x2, y2, x3, y3);
      }
    }
    return lines;
  }
}*/