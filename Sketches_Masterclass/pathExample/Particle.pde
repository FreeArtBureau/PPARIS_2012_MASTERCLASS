class Particle {
  UVertexList path;
  UVec3 pos,dir;
  float speed,rot;
  
  Particle() {
    path=new UVertexList();
    pos=new UVec3();
    path.add(pos);
    
    speed=random(4,8);
    rot=random(-3,3);
    dir=new UVec3(speed,0);
    dir.rotate(radians(rot));
  }
  
  void draw() {
    rot=rot+random(-0.5,0.5);
    dir.rotate(radians(rot));
    pos.add(dir);
    
    UVec3 D=new UVec3(pos);
    D.sub(path.v[path.n-1]);
    float angle=D.angle2D();
    
    UVec3 nrm=new UVec3(10,0,0); // normal vector
    nrm.rotate(HALF_PI+angle);
    stroke(0,255,0);
    line(pos.x,pos.y, pos.x+nrm.x,pos.y+nrm.y);
    
    path.add(pos);
    
    stroke(255,0,0);
    line(pos.x,pos.y, pos.x+dir.x,pos.y+dir.y);
    
    stroke(255);
    path.draw(papplet);
  }
}
