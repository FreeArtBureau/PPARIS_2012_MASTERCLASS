UColorTool colors;

void initColors() {
  colors=new UColorTool();
//  colors.add(255,0,0);
//  colors.add(255,100,0);
//  colors.add(255,200,0);
  colors.addGradient(3,10, color(255,0,0), color(255,200,0));
  colors.addGradient(3,10, "00FFFF","FFFFFF");
  
  colors.generateColors();
}
