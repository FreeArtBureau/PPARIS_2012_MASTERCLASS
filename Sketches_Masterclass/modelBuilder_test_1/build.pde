
UVertexList vl,vl2;

void build() {
  vl=new UVertexList();
  vl2=new UVertexList();
  
  float n=20;
  for(int i=0; i<n; i++) {
    float t=(float)i/(n-1);
    vl.add(t*(float)width,
      random(0.25,0.5)*(float)height,
      random(-0.15,0.15)*(float)width);
    vl2.add(t*(float)width,
      random(0.75,1)*(float)height,
      random(-0.15,0.15)*(float)width);
  }
}
