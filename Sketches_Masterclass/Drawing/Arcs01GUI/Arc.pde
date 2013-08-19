class Arc {
  float a,aD,r1,r2,steps;
  
  Arc() {
    steps=(int)(random(5,10)*stepMod*((float)n/150f+0.1f));
    a=random(TWO_PI);
    aD=radians(random(10,30)*aMod)/steps;
    if(random(100)>90) aD*=1.5f;
    r1=random(rmin,(rmax+rmin)*0.5f);
    r2=r1+random(20,(rmax-r1)*rMod);
  }
  
  public void draw() {
    pushMatrix();
    rotate(a);
    for(int j=0; j<steps; j++) {
      float t=map(j,0,steps-1,0,1);
      line(r1,0,r2,0);
      rotate(aD);
    }
    popMatrix();
  } 
}

