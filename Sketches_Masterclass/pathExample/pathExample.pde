import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

import processing.opengl.*;

PApplet papplet;
Particle part[];
int n;

void setup() {
  size(600,600, OPENGL);
  
  papplet=this;
  
  n=(int)random(5,20);
  part=new Particle[n];
  for(int i=0; i<n; i++) part[i]=new Particle();
  
  frameRate(5);
}

void draw() {
  background(0);
  noFill();
  
  translate(width/2,height/2);
  for(int i=0; i<n; i++) part[i].draw();
}

