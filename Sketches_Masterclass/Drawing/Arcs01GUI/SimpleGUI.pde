class SimpleGUI {
  PApplet p;
  ControlP5 cp;
  float cpx, cpy, cpw, cph;

  SimpleGUI(PApplet _p) {
    p=_p;
    cp=new ControlP5(p);
    cp.setAutoDraw(false);
    cp.setColorActive(color(255,200,0));
    cp.setColorLabel(color(0,150,200));  
    
    cpw=150;
    cph=10;
    addPos(5, 5);
  }

  public void draw() {
    hint(DISABLE_DEPTH_TEST);
    fill(200, 100);
    noStroke();
    rect(0, 0, cpw, cph);
    cp.draw();
    hint(ENABLE_DEPTH_TEST);
  }

  public void addButton(String name) {
    Button tmpbut=cp.addButton(name, 1, (int)cpx, (int)cpy, 100, 15);
    addPos(0, 17);
  }

  public void addSlider(
    String name, float val, float min, float max) {

    Controller sl=cp.addSlider(name, min, max, val, (int)cpx, (int)cpy, 100, 15);
    addPos(0, 17);
  }


  public void setPos(float _x, float _y) {
    cpx=(int)_x;
    cpy=(int)_y;
  }

  public void addPos(float _x, float _y) {
    cpx+=(int)_x;
    cpy+=(int)_y;
    cph+=_y;
  }
}

