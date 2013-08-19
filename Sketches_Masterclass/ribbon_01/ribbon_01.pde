import controlP5.*;

import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

import processing.opengl.*;

PApplet parent;
Ribbon ribbon[];
int ribn;

void setup() {
  size(600,600, OPENGL);
  parent=this;
  
  reinit();
}

void draw() {
  background(255);
  translate(width/2,height/2);
  
  noFill();
  stroke(0);
  for(int i=0; i<ribbon.length; i++) {
    ribbon[i].update();
    ribbon[i].draw();
  }
}

void reinit() {
  ribn=(int)random(5,20);
  ribbon=new Ribbon[ribn];
  for(int i=0; i<ribn; i++) ribbon[i]=new Ribbon();
}



