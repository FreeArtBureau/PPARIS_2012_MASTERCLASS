class Ribbon {
  UVertexList vl[];
  UVec3 pos, oldPos;
  int vln, col1, col2;
  float a, rotStart, rotEnd;
  float speed, drawLength, distTravelled;
  float rad, radMod[];

  boolean dead;

  Ribbon() {
    a=random(TWO_PI);
    rotStart=radians(random(-maxRot, maxRot));
    rotEnd=radians(random(-maxRot, maxRot));


    speed=random(4, 8);
    if (random(100)>90) speed+=4;

    // distance to draw before ribbon is done
    drawLength=random(0.3f, 0.5f)*(float)width;
    if (random(100)>80) drawLength=random(0.5f, 0.75f)*(float)width;

    rad=random(2, 4);
    radMod=new float[] {
      random(5), random(0.35, 0.6)*maxFat, random(0.7, 1)*maxFat, 0
    };

    if (random(100)>90) rad=random(6, 8); 

    vln=(int)random(3, 6)*2;
    vl=UVertexList.getVertexLists(vln);

    pos=new UVec3();
    oldPos=new UVec3();

    col1=color(0);
    int colChoice=(int)random(3);
    if (colChoice==0) col2=color(0, random(100, 255), 255);
    if (colChoice==1) col2=color(255, random(100, 255), 0);
    if (colChoice==2) col2=color(255);
  }

  public void draw() {
    UVertexList newPt;

    if (!dead) update();

    pushMatrix();
    rotate(a);

    for (int i=0; i<vln-1; i++) {
      // alternating colors
      fill(col1);
      if (i%2==1) fill(col2);

      UGeometry.drawQuadstrip(papplet, vl[i], vl[i+1]);
    }

    popMatrix();
  }

  void update() {
    UVertexList newPt; 

    float travelT=min(distTravelled/drawLength, 1);

    // calc new points
    newPt=new UVertexList();

    for (int i=0; i<vln; i++) {
      float pty=map(i, 0, vln-1, -0.5f, 0.5f);
      newPt.add(0, pty, 0);
    }

    // transform newPt
    float modifier=bezierPoint(
    radMod[0], radMod[1], radMod[2], radMod[3], 
    travelT);

    newPt.scale(rad*modifier);

    // get angle between old position and new position
    newPt.rotateZ(oldPos.sub(pos).angle2D());

    newPt.translate(pos);
    // add new points
    for (int i=0; i<vln; i++) vl[i].add(newPt.v[i]);

    // stop drawing?
    if (distTravelled>drawLength) dead=true;

    // update speed and rad
    oldPos.set(pos);
    pos.add(speed, 0, 0);
    pos.rotate(map(travelT, 0, 1, rotStart, rotEnd));

    distTravelled=distTravelled+speed;
  }
}

