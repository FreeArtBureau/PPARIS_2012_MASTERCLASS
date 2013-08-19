public void unwrap() {
  unwrapper=new UGeometry();
  unwrapper.translate(200, 0, 0);

  UFace f[]=(UFace [])UUtil.expandArray(model.face, model.faceNum);
  float x=0, y=0, h=0;
  UFace last=null;
  UVec3 pairEdge=new UVec3(), v=new UVec3();
  for (int i=0; i<f.length; i++) {//if(i<10) {//<2*(evalNum*2-1)) {
    UFace ff=new UFace(f[i].v[0], f[i].v[1], f[i].v[2]);
    ff.flatten();
    if (i%2==1) {
      v.set(last.v[2]).sub(last.v[1]);
      ff.rotateZ(v.angle2D()-new UVec3(ff.v[0]).sub(ff.v[1]).angle2D());

      ff.translate(last.v[2].x-last.v[1].x, last.v[2].y-last.v[1].y, last.v[2].z-last.v[1].z);
      if (i>2) {
        v.set(last.v[2]).sub(last.v[1]);

        pairEdge.set(unwrapper.face[unwrapper.faceNum-2].v[1]).
          sub(unwrapper.face[unwrapper.faceNum-1].v[0]).mult(1);
      }
    }

    ff.translate(x, y, 0);

    UVec3 dim=ff.getDimensions();
    x+=dim.x;
    h=PApplet.max(h, dim.y);

    if (i%(2*(evalNum*2-1))==(2*(evalNum*2-1))-1) {
      x=0;
      y+=h+25;
      h=0;
    }

    unwrapper.add(ff);
    last=ff;
  }

  unwrapper.center().translate(-unwrapper.bb.min.x, 0, 0);

  for (int i=0; i<unwrapper.faceNum; i++) unwrapper.face[i].calcCentroid();


  println("Model faces: "+unwrapper.faceNum+" "+model.faceNum);
}

void drawUnwrapped() {
  translate(model.bb.sz.x, 0, 0);
  scale(0.75f);
  fill(0);
  textAlign(CENTER);
  for (int i=0; i<unwrapper.faceNum; i++) {
    fill((i*120)%255);
    unwrapper.face[i].draw(this);

    fill(0);
    for (int j=0; j<3; j++) {
      pushMatrix();
      translate(unwrapper.face[i].v[j].x, unwrapper.face[i].v[j].y, unwrapper.face[i].v[j].z+5);
      scale(0.25f);
      text(""+j, 0, 0);
      popMatrix();

      pushMatrix();
      UVec3 c=unwrapper.face[i].centroid;
      translate(c.x, c.y, c.z+5);
      scale(0.25f);
      int row=(i/2)/(evalNum*2-1);
      text(row+"|"+i, 0, 0);
      popMatrix();
    }
  }
}
