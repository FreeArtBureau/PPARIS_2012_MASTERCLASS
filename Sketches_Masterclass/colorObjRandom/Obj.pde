class Obj {
  float x,y,sz;
  int col;
  
  Obj() {
    x=random(width);
    y=random(height);
    sz=random(40,100);
    
    col=color(random(255),random(255),random(255));
  }
  
  void draw() {
    fill(col);
    ellipse(x,y, sz,sz);
  }
}
