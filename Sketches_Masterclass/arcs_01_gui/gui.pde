USimpleGUI gui;
int n;
float minRad,radDelta;
float minDeg,degDelta;
float radMod,stepsMod;

void initGUI() {
  n=(int)random(20,100);
  minRad=0.2;
  radDelta=0.3;
  minDeg=30;
  degDelta=30;
  radMod=1;
  stepsMod=1;
  
  gui=new USimpleGUI(this);
  gui.addSlider("n",n, 1,200);
  gui.addSlider("stepsMod",stepsMod,0.1,5);
  gui.addSlider("minDeg", minDeg, 1,180);
  gui.addSlider("degDelta", degDelta, 1,180);
  gui.addSlider("minRad", minRad, 0,0.5);
  gui.addSlider("radDelta", radDelta, 0.01,0.5);
  gui.addSlider("radMod", radMod, 0.01,1);
  
  gui.addButton("reinit");
}
