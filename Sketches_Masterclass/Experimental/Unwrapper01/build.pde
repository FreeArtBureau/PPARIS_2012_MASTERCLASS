public void build() {
  UVertexList vl[]=UVertexList.getVertexLists(vlNum);
  UBezier3D bez[]=new UBezier3D[vl.length];

  for (int i=0; i<vl.length; i++) {
    // build bezier path
    for (int j=0; j<7; j++) {
      float x=random(-rand*0.5, rand*0.25);
      if (j%2==0) x=random(rand*1.5f, rand*2);
      x=max(offs*0.5,x+offs);
      
      UVec3 vv=new UVec3(x, j*60, 0).
        rotateY(random(-0.45, 0.45)*TWO_PI/(float)vl.length);
      float m=bezierPoint(1.5f, 0.2f, 0.5f, 1f, (float)j/6f);
      vv.mult(m, 1, m);
      vl[i].add(vv);
    }

    vl[i].rotateY(TWO_PI*(float)i/(float)vl.length);

    bez[i]=new UBezier3D().set(vl[i]).eval(evalNum);
    vl[i]=bez[i].result;
  }

  model=new UGeometry().quadStrip(vl);
  model.quadStrip(vl[vl.length-1], vl[0]);
  model.center().rotateX(PI);

  unwrap();
}

