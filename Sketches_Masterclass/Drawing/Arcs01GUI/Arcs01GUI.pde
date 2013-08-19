import controlP5.*;

import processing.pdf.*;

int n,currN;
Arc arc[];
String name;
float sz,rmin,rmax,stepMod,rMod,aMod;
SimpleGUI controller;

boolean doSave=false;

void setup() {
  size(800,800);
  
  initGUI();
  regenerate();
  
  smooth();
}

void draw() {
  
  background(255);
  
  if(doSave) {  
     name=getIncrementalFilename("ArcDrawings-####.pdf");  
     println("Saving "+name);  
     beginRecord(PDF,name);
  }  
  
  pushMatrix();
  translate(width/2,height/2);
  strokeWeight(1/sz);
  scale(sz);
  
  noFill();
  stroke(0);
  for(int i=0; i<currN; i++) {
    arc[i].draw();
  }
  popMatrix();
  
  if(doSave) {  
    endRecord();
    println("Done.");
     doSave=false;  
  }

  controller.draw();
}

void savefile() {
  doSave=true; 
}

void regenerate() {
  float maxr=0;
  
  currN=n;
  arc=new Arc[currN];
  for(int i=0; i<currN; i++) {
    arc[i]=new Arc();
    maxr=max(maxr, arc[i].r2);
  }
  sz=((float)width*0.45f)/(maxr);

}

void randomize() {  
  controller.cp.controller("n").setValue((int)random(5,150));  
  controller.cp.controller("rmin").setValue(random(50,100));
  controller.cp.controller("rmax").setValue(random(100,300));
  controller.cp.controller("rMod").setValue(random(0.25,1.25));
  controller.cp.controller("aMod").setValue(random(0.25,3));
  controller.cp.controller("stepMod").setValue(random(1,4));
  
  regenerate();
}
  

