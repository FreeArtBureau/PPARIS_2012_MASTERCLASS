class Particle {
  UVertexList vl, vl2;
  UVec3 pos;
  int c;
  float cAlpha,vmod;
  int numpt, stipple=-1;

  public Particle() {
    vl=new UVertexList();
    vl2=new UVertexList();
    pos=new UVec3(random(0.75f, 1.25f)*sphereRad, 0, 0);
    pos.rotateY(random(TWO_PI)).rotateX(random(TWO_PI));

    addPoint();

    vmod=random(0.2f, 0.4f);
    if (random(100)>90) vmod=random(0.5f, 0.8f);

    c=col.getRandomColor();
    cAlpha=random(100,200);

    numpt=(int)random(50, 125);

    if (random(100)>80) stipple=(int)random(6, 10);
    
  }

  void addPoint() {
    vl.addAtStart(pos);
    vl2.addAtStart(
    new UVec3(-pos.x, -pos.y, -pos.z).
      mult(vmod).add(pos));
    if (vl.n>numpt) {
      vl.n=numpt;
      vl2.n=numpt;
    }
  }

  void draw() {
    stroke(c);

    pos.rotateY(globalRotY).rotateX(globalRotX);
    pos.norm(pos.length()+radD);

    addPoint();

    noStroke();

    beginShape(QUAD_STRIP);
    UVec3 v1, v2=new UVec3();
    for (int i=0; i<vl.n;i++) {
      float t=(float)i/(float)(vl.n-1);
      v1=vl.v[i];
      v2=vl2.v[i];
      
      // use solid color for outside vertices
      fill(c);
      vertex(v1.x, v1.y, v1.z);
      // use color with alpha for outside vertices
      fill(c, (int)cAlpha);
      vertex(v2.x, v2.y, v2.z);

      // handle stippling if stipple>-1
      if (stipple>-1 && i>0) {
        if (i%stipple==0) endShape();
        if (i%stipple==2 && i<vl.n-(stipple-2)) beginShape(QUAD_STRIP);
      }
    }
    endShape();
  }
}

