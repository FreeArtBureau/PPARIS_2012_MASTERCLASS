
void build() {
  outline=new UVertexList[2];
  outline[0]=new UVertexList();
  outline[0].add(-200,0,-200);
  outline[0].add(200,0,-200);
  outline[0].add(100,0,0);
  outline[0].add(200,0,200);
  outline[0].add(-200,0,200);
  outline[0].close();
  
  outline[1]=new UVertexList(outline[0]);
  outline[1].translate(0,100,0);
  
  geo=new UGeometry();
  geo.quadStrip(outline[0],outline[1], false);
  
  // do triangle fan of outline[0], use the centroid
  // and reverse the order
  geo.triangleFan(outline[0],true,true);
  geo.triangleFan(outline[1],true,false);
  
  geo.writeSTL(this, "Simple3D.stl");
}
