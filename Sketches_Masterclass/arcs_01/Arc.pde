class Arc {
  // a is start angle, b is end angle
  // r1 is inner radius, r2 is outer radius
  float a,b,r1,r2;
  float steps,stepsDeg;
  
  // constructor
  Arc() {
    a=random(TWO_PI);
    b=a+radians(random(60,120));
    r1=random(0.2,0.3)*width;
    r2=random(0.3,0.5)*width;
    
    steps=(int)(degrees(b-a)/5);
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
