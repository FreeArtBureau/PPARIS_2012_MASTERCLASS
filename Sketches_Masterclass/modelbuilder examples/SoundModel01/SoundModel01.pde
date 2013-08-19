import controlP5.*;

import processing.opengl.*;

import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

import processing.opengl.*;

import ddf.minim.*;
import ddf.minim.analysis.*;

ArrayList sndData=new ArrayList();
String filename;
float globalMaxLevel=0;

// GUI PARAMETERS
float ampl=50;
float xScale=10;
float yOffs=50;

Minim minim;
AudioPlayer player;
FFT fft;
int fftSize;
float fftW;
long playStart,recDuration;
boolean doRebuild=false;

UNav3D nav;
UGeometry model;
PApplet papplet;
PFont fnt;

void setup() {
  size(600,600, OPENGL);
  
// lady gaga vs. skrillex
//  filename="03 - Bad Romance (Skrillex Remix).mp3";

  // michael nyman
  filename="04 - 4 - the heart ask pleasure first.mp3";
  //filename="05 - 5 - here to there.mp3";
//  filename="07 - 7 - a bed of ferns.mp3";
  
  minim=new Minim(this);
  player=minim.loadFile(filename);
  
  initGUI();
  smooth();  

  fft = new FFT (player.bufferSize(), player.sampleRate());
  fft.logAverages (60, 7);
  fftSize=fft.avgSize();
  
  // cut off last n slices of the FFT
  fftSize=fftSize-20;
  println("specsize "+fft.specSize()+" avgsize "+fft.avgSize());
  
  stroke(255);
  fftW = ((float)width/(float)fftSize);
  
  papplet=this;
  player.skip(0*1000); 
  player.play();
  playStart=millis();
  recDuration=10*1000;
  frameRate(30);
}

void draw() {
  background(0);
  lights();

  long now=millis();
  if (now-playStart<recDuration) record();
  else if(model==null || doRebuild) build();
  
  if(model!=null) {
    hint(ENABLE_DEPTH_TEST);
    pushMatrix();
    nav.doTransforms();

    noStroke();
    fill(255);
    
    model.draw(this);
    popMatrix();

    // trick to make GUI draw on top
    hint(DISABLE_DEPTH_TEST); 
    controlP5.draw();
  }
  
}
