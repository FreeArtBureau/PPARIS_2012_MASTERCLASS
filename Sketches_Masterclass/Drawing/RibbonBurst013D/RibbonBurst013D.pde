import processing.pdf.*;

import controlP5.*;

import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

import processing.opengl.*;

Ribbon ribbon[];
int ribn=25;
PApplet papplet;
boolean doSave;
String filename;
float maxRot=1,maxFat=30;

public void setup() {
  size(800, 800, OPENGL);

  // store reference to PApplet
  papplet=this;

  if(ribbon==null) {
    reinit();
    initGUI();
  }
  
  smooth();
  hint(ENABLE_OPENGL_4X_SMOOTH);
}

public void draw() {
  background(255);
  
  if(doSave) {
    String nameFormat=this.getClass().getSimpleName();
    nameFormat=nameFormat+" ####.pdf";
    filename=UIO.getIncrementalFilename(nameFormat, sketchPath);

    beginRaw(PDF,filename);
    println("Saved '"+filename+"'");
  }
  
  pushMatrix();
  translate(width/2, height/2);

  noStroke();
  for (int i=0; i<ribbon.length; i++) ribbon[i].draw();
  
  popMatrix();
  
  if(doSave) {
    endRaw();
    saveFrame(UIO.noExt(filename)+".png");
    doSave=false;
  }
  
  gui.draw();
}

public void reinit() {
  ribbon=new Ribbon[ribn];

  for (int i=0; i<ribn; i++) ribbon[i]=new Ribbon();
}

public void savePDF() {
  doSave=true;
}

public void keyPressed() {
  if (key==' ') reinit();
}
