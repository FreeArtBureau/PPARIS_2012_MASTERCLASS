ControlP5 controlP5; // instance of the controlP5 library

void initGUI() {
  n=100;
  rmin=random(50,100);
  rmax=rmin+random(100,300); 
  stepMod=random(1,3);  
  rMod=random(0.25,1.25);  
  aMod=random(0.25,3);  

  controller=new SimpleGUI(this);
  controller.addSlider("n", n, 20, 200);
  controller.addSlider("rmin", rmin, 5, 100);
  controller.addSlider("rmax", rmax, 150, 450);
  controller.addSlider("stepMod", stepMod, 0.5,4);
  controller.addSlider("rMod", rMod, 0.2,1.5);
  controller.addSlider("aMod", aMod, 0.2, 4);

  controller.addPos(0,10);
  controller.addButton("regenerate");
  controller.addButton("savefile");
  controller.addButton("randomize");
}

void controlEvent(ControlEvent theEvent) {
  Controller c=theEvent.controller();
//  println(c.label()+" "+c.id()+" "+c.value());
  
//  if(c.id()==0) num=(int)c.value();
}

