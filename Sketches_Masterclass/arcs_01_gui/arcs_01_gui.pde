import controlP5.*;

import unlekker.util.*;
import unlekker.modelbuilder.*;

Arc arcs[];

void setup() {
  size(600,600);
  smooth();
  
  initGUI();
  reinit();
}

void draw() {
  background(255);
  
  pushMatrix();
  translate(width/2,height/2);
  
  noFill();
  stroke(0);
  for(int i=0; i<min(n, arcs.length); i++) 
    arcs[i].draw();
  popMatrix();
  
  gui.draw();
}

void reinit() {
  arcs=new Arc[n];
  
  for(int i=0; i<n; i++) arcs[i]=new Arc();
}

void keyPressed() {
  if(key==' ') reinit();
}






