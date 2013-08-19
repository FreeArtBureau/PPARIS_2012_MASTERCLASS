import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

Obj o[];
int n;

void setup() {
  size(600,600);
  
  reinit();
}

void draw() {
  background(0);
  noStroke();
  
  for(int i=0; i<n; i++) o[i].draw();
  
  colors.drawColors(this,0,0);
}

void mousePressed() {
  reinit();
}

void reinit() {
  initColors();
  
  n=(int)random(50,100);
  o=new Obj[n];
  for(int i=0; i<n; i++) o[i]=new Obj();   
}
  
  
  
