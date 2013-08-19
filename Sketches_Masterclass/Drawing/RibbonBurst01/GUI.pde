USimpleGUI gui;

void initGUI() {
  gui=new USimpleGUI(this);
  gui.addSlider("ribn", ribn,5,200);
  gui.addSlider("maxRot", maxRot,0,5);
  gui.addSlider("maxFat", maxFat,10,80);
  gui.addPos(0,10);
  gui.addButton("reinit");
  gui.addButton("savePDF");
}
