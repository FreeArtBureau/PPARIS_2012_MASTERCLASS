// Demonstrates realtime 3D animation.
// Things to note:
// - Use of UColorTool to generate wide range of
//   possible palettes
// - Use of UVertexList to generate 3D surfaces
// - Use of vertex-specific color to create blend effect
// - Use of appScale trick to adapt sketch to any given
//   screen resolution


import java.util.ArrayList;
import controlP5.*;
import unlekker.modelbuilder.*;
import unlekker.util.*;

import processing.opengl.*;

UNav3D nav;
USimpleGUI gui;
PApplet papplet;
float appScale;

float sphereRad, globalRotX, globalRotY, globalRad;
float rotXD, rotYD, radD;
int partn, stateCount, stateCountGoal;

Particle part[];
UColorTool col;

public void setup() {
  size(800,800,OPENGL);
//  size(screen.width, screen.height, OPENGL);

  // this sketch was first created at 800x800 resolution. 
  // if run at another resolution it is scaled appropriately
  appScale=(float)width/800;
  println(appScale+" "+appScale);

  papplet=this;	
  nav=new UNav3D(this);
  nav.setTranslation(width/2,height/2,0);
  
  gui=new USimpleGUI(this);
  gui.addButton("reinit");
  gui.addButton("newColors");
  gui.addButton("saveImage");
  
  reinit();
  smooth();
  frameRate(30);
}

public void draw() {
  background(0);				
  lights();

  hint(ENABLE_DEPTH_TEST);
  pushMatrix();

  nav.doTransforms();
  
  // scale whole sketch so it looks good at any
  // given res
  scale(appScale);

  update();
  noStroke();
  for (int i=0; i<partn; i++) part[i].draw();

  popMatrix();

  hint(DISABLE_DEPTH_TEST);
  gui.draw();
    
//  fill(255);
//  text("fps "+nf(frameRate, 0, 2)+" "+partn+" "+nf(globalRad,0,2), 140, 20);
}

void update() {
  float m=0.025f;

  globalRotX+=rotXD;
  globalRotY+=rotYD;
  globalRad+=radD;

  nav.rot.add(radians(0.01f), radians(0.02f), 0);

  stateCount++;
  if (stateCount==stateCountGoal-1) newMove();
}

public void saveImage() {
  String nameFormat=this.getClass().getSimpleName();
  nameFormat=nameFormat+" ####.png";

  String filename=UIO.getIncrementalFilename(nameFormat, sketchPath);
  saveFrame(filename);

  println("Saved '"+filename+"'");
}


