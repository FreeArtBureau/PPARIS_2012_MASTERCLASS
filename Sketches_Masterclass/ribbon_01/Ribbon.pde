class Ribbon {
  UVertexList vl[];
  float speed,rad;
  UVec3 pos,posLast;
  int vln;
  float rotStart,rotEnd;
  float deg;
  
  Ribbon() {
    vln=2;
    vl=new UVertexList[vln];
    for(int i=0; i<vln; i++) vl[i]=new UVertexList();
    
    deg=random(TWO_PI);
    speed=random(4,8);
    rotStart=radians(random(-2,2));
    rotEnd=radians(random(-2,2));
    
    pos=new UVec3(0,0);
    posLast=new UVec3(0,0);
  }
  
  void draw() {
    pushMatrix();
    rotate(deg);
    vl[0].draw(parent);
    popMatrix();
  }
  
  void update() {
    posLast.set(pos);
    pos.set(speed,0);
    println(pos.toString());
    pos.add(posLast);
    pos.rotateZ(rotStart);
    vl[0].add(pos);   
  }
}
