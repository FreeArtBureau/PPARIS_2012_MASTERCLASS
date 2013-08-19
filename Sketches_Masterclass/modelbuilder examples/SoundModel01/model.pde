void build() {
  player.pause();
  model=new UGeometry();

  if (globalMaxLevel<1) { // find max level and normalize
    for (int i=0; i<sndData.size(); i++) {
      SpectrumFrame curr=(SpectrumFrame)sndData.get(i);
      globalMaxLevel=max(globalMaxLevel, curr.maxLevel);
    }

    for (int i=0; i<sndData.size(); i++) {
      SpectrumFrame curr=(SpectrumFrame)sndData.get(i);
      curr.normalize();
    }
  }

  float deg=TWO_PI/(float)sndData.size();

  UVertexList bottom=new UVertexList();
  UVertexList top=new UVertexList();
  UVertexList bottomInside=new UVertexList();
  UVertexList topInside=new UVertexList();

  SpectrumFrame current=null, last=null;
  
  for (int b=0; b<sndData.size(); b++) {
    last=current;
    current = (SpectrumFrame) sndData.get(b);
    current.build();

    current.vl.translate(0, yOffs, 0);
    current.vl.rotateX((float)b*deg);

    bottom.add(current.vl.v[0]);
    top.add(current.vl.v[current.vl.n-1]);
    if (last!=null) model.quadStrip(current.vl, last.vl);
  }

  last = (SpectrumFrame) sndData.get(0);
  bottom.add(last.vl.v[0]);
  top.add(last.vl.v[current.vl.n-1]);
  model.quadStrip(last.vl, current.vl);   

  float r1=10000, r2=10000;
  for (int i=0; i<top.n; i++) {
    float rr=dist(top.v[i].x, top.v[i].y, top.v[i].z, 
    top.v[i].x, 0, 0);
    if (rr<r1) r1=rr;
    rr=dist(bottom.v[i].x, bottom.v[i].y, bottom.v[i].z, 
    bottom.v[i].x, 0, 0);
    if (rr<r2) r2=rr;
  }

  r1=r1-yOffs*0.5;
  r2=r2-yOffs*0.5;

  for (int i=0; i<top.n; i++) {
    topInside.add(new UVec3(top.v[0].x, r1, 0).rotateX((float)i*deg));
    bottomInside.add(new UVec3(bottom.v[0].x, r2, 0).rotateX((float)i*deg));
  }

  model.quadStrip(bottomInside, bottom);   
  model.quadStrip(top, topInside);   
  model.quadStrip(topInside, bottomInside);   

  model.center();
  model.rotateZ(HALF_PI);
}

