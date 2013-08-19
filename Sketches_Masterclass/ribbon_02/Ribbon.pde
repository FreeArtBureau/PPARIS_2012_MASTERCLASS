class Ribbon {
  UVertexList vl[];
  float speed,rad;
  UVec3 pos,posLast;
  int vln;
  float rotStart,rotEnd;
  float deg,radMod[];
  
  // distTotal is the total length to travel
  // distTravelled is the current distance travelled
  float distT,distTotal,distTravelled;
  boolean dead;
  
  Ribbon() {
    vln=6;
    vl=new UVertexList[vln];
    for(int i=0; i<vln; i++) vl[i]=new UVertexList();
    
    deg=random(TWO_PI);
    speed=random(4,8);
    rotStart=radians(random(-2,2));
    rotEnd=radians(random(-2,2));
    
    pos=new UVec3(0,0);
    posLast=new UVec3(0,0);
    
    distTotal=random(0.3,0.5)*(float)width;
    distTravelled=0;
    
    radMod=new float[4];
    radMod[0]=0.02;
    radMod[1]=random(0.5,1.5)*100;
    radMod[2]=random(0.5,1.5)*100;
    radMod[3]=1;
    
    addPoint();
  }
  
  void draw() {
    pushMatrix();
    rotate(deg);
    
    noStroke();
    for(int i=0; i<vln-1; i++) {
      if(i%2==0) fill(0);
      else fill(255);
      UGeometry.drawQuadstrip(parent, vl[i],vl[i+1]);
    }
    popMatrix();
  }
  
  void addPoint() {
    UVertexList newPt=new UVertexList();
    for(int i=0; i<vln; i++)
      newPt.add(0,map(i, 0,vln-1,-0.5,0.5));
      
    newPt.scale(
      bezierPoint(radMod[0],radMod[1],
        radMod[2],radMod[3], distT)
    );
        
    UVec3 angleV=new UVec3(pos).sub(posLast);
    float angle=angleV.angle2D();
    newPt.rotateZ(angle);
    newPt.translate(pos);

    for(int i=0; i<vln; i++) vl[i].add(newPt.v[i]);
  }
  
  void update() {
    distT=distTravelled/distTotal;
    if(distT>1) distT=1;
    
    posLast.set(pos);
    pos.set(speed,0);
    pos.rotateZ(rotStart*(float)vl[0].n);

    pos.add(posLast);
//    pos.rotateZ(rotStart);
    
    addPoint();
    
    distTravelled=distTravelled+speed; 
    if(distTravelled>distTotal) dead=true;
  }
}
