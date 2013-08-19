Arc arcs[];
int n;

void setup() {
  size(600,600);
  smooth();
  
  reinit();
}

void draw() {
  background(255);
  translate(width/2,height/2);
  
  noFill();
  stroke(0);
  for(int i=0; i<n; i++) arcs[i].draw();
}

void reinit() {
  n=(int)random(20,100);
  arcs=new Arc[n];
  
  for(int i=0; i<n; i++) arcs[i]=new Arc();
}

void keyPressed() {
  if(key==' ') reinit();
}






