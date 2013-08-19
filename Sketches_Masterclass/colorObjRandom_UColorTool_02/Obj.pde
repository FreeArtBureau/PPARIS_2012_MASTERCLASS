class Obj {
  float x,y,sz;
  int col;
  
  Obj() {
    x=random(width);
    y=random(height);
    sz=random(40,100);
    
    col=colors.getRandomColor();
    col=UColorTool.setAlpha(col, random(150,200));
  }
  
  void draw() {
    fill(col);
    ellipse(x,y, sz,sz);
  }
}
