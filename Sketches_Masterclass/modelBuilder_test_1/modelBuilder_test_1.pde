import processing.opengl.*;

import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

void setup() {
  size(1000,600, OPENGL);
  smooth();
  
  build();
}

void draw() {
  background(100);
  lights();
  
  fill(255,100,0);
  UGeometry.drawQuadstrip(this, vl,vl2);
//  for(int i=0; i<vl.n; i++)
//    line(vl2.v[i].x,vl2.v[i].y, vl.v[i].x,vl.v[i].y);
}

void mousePressed() {
  build();
}


