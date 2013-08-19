class Arc {
  // a is start angle, b is end angle
  // r1 is inner radius, r2 is outer radius
  float a,b,r1,r2;
  float steps,stepsDeg;
  
  // constructor
  Arc() {
    a=random(TWO_PI);
    b=a+radians(random(minDeg,minDeg+degDelta));
    r1=random(minRad,minRad+radDelta*0.25)*width;
    r2=r1+random(0.25,0.5)*(minRad+radDelta)*width*radMod;
    
    steps=(int)(stepsMod*degrees(b-a)/5);
    stepsDeg=(b-a)/(steps);
  }
  
  void draw() {
    float x,y;
    
    for(float i=0; i<steps; i++) {
      x=cos(a+i*stepsDeg);
      y=sin(a+i*stepsDeg);
      line(x*r1,y*r1, x*r2,y*r2);
    }
  }
}
