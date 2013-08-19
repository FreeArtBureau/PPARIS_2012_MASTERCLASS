UColorTool colors;

void initColors() {
  colors=new UColorTool();
//  colors.add(255,0,0);
//  colors.add(255,100,0);
//  colors.add(255,200,0);
  colors.addGradient(3,10, color(255,0,0), color(255,200,0));
  colors.addGradient(3,10, "00FFFF","FFFFFF");
  colors.addGradient(3,10, color(0,100,0), color(100,255,0));
  
  // generate min. 5 colors, 50% chance of dropping any
  // given gradient
  colors.generateColors(5, 90);
}
