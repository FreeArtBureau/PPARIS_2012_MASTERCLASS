import controlP5.*;

import processing.pdf.*;

import processing.opengl.*;

import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

UGeometry model, unwrapper;
UNav3D nav;
USimpleGUI gui;
int evalNum=5, vlNum=6;
float offs=80, rand=30;
boolean doPDF;
String filename;

public void setup() {
  size(1000, 800, OPENGL);

  nav=new UNav3D(this);
  nav.setTranslation(width/2, height/2, 0);

  if (model==null) {
    build();
    initGUI();
  }

  smooth();
  hint(ENABLE_OPENGL_4X_SMOOTH);

  textFont(createFont("arial", 20, false));
}

public void draw() {
  background(255);

  lights();

  pushMatrix();

  nav.doTransforms();
  stroke(0);
  fill(255, 100, 0);

  translate(-400-model.bb.min.x/2, 0, 0);
  pushMatrix();
  rotateY(radians(frameCount));
  for (int i=0; i<unwrapper.faceNum; i++) {
    model.face[i].draw(this);
  }
  popMatrix();

  drawUnwrapped();

  popMatrix();

  gui.draw();
}


public void initGUI() {
  gui=new USimpleGUI(this);
  gui.addSlider("vlNum", vlNum, 2, 30);
  gui.addSlider("evalNum", evalNum, 2, 30);
  gui.addSlider("offs", offs, 0, 300);
  gui.addSlider("rand", rand, 0, 200);
  gui.addButton("build");
  gui.addButton("saveSTL");
  gui.addButton("savePDF");
}

public void savePDF() {
  saveSTL();
  
  PGraphicsPDF pdf=(PGraphicsPDF)createGraphics(1000, 2000, PDF, 
    UIO.noExt(filename)+".pdf");
  String [] s=PGraphicsPDF.listFonts();
  String fntName="";
  for (int i=0; i<s.length; i++) if (s[i].indexOf("rial")!=-1) {
    fntName=s[i];
    println(fntName);
    i=s.length;
  }

  pdf.beginDraw();
  unwrapper.calcBounds();
  pdf.translate(-unwrapper.bb.min.x,-unwrapper.bb.min.y);

  pdf.textFont(createFont(fntName, 20));
  pdf.fill(0);
  pdf.textAlign(CENTER);
  pdf.hint(ENABLE_NATIVE_FONTS);
  for (int i=0; i<unwrapper.faceNum; i++) {
    for (int j=0; j<3; j++) {
      pdf.pushMatrix();
      UVec3 p=new UVec3(unwrapper.face[i].v[j]);
      p.add(unwrapper.face[i].v[(j+1)%3]).div(2);
      UVec3 cp=new UVec3(unwrapper.face[i].centroid).
        sub(p).mult(0.35f);
      p.add(cp);

      pdf.translate(p.x, p.y);
      pdf.scale(0.25f);
      pdf.text(""+j, 0, 0);
      pdf.popMatrix();
    }

    pdf.pushMatrix();
    UVec3 c=unwrapper.face[i].centroid;
    pdf.translate(c.x, c.y);
    pdf.scale(0.25f);
    int row=(i/2)/(evalNum*2-1);
    int face=i-(row*(evalNum*2-1)*2);
    pdf.text(row+"|"+face, 0, 0);
    pdf.popMatrix();

    pdf.noFill();
    pdf.triangle(unwrapper.face[i].v[0].x, unwrapper.face[i].v[0].y, 
    unwrapper.face[i].v[1].x, unwrapper.face[i].v[1].y, 
    unwrapper.face[i].v[2].x, unwrapper.face[i].v[2].y);
  }
  pdf.endDraw();
  pdf.dispose();
}

public void saveSTL() {
  filename=UIO.getIncrementalFilename(
    this.getClass().getSimpleName()+" ###.stl",sketchPath);

  model.writeSTL(this, filename);
}

public void keyPressed() {
  if (key==' ') build();
  if (key=='s') {
    String nameFormat=this.getClass().getSimpleName();
    nameFormat=nameFormat+" ####.png";

    String filename=UIO.getIncrementalFilename(nameFormat, sketchPath);
    saveFrame(filename);

    println("Saved '"+filename+"'");
  }
}

