public void reinit() {
  sphereRad=300;
  globalRad=sphereRad;
  newColors();
  
  partn=(int)random(50, 125);
  part=new Particle[partn];
  for (int i=0; i<partn; i++) part[i]=new Particle();
  
  newMove();
}

void newColors() {
  col=new UColorTool();
  col.addGradient(3, 10, "FF0000", "990000");
  col.addGradient(3, 10, "FFFFFF", "FFFF00");
  col.addGradient(3, 10, "003366", "00FFFF");
  col.addGradient(3, 10, "FFCC00", "FF6600");
  col.addGradient(3, 10, "003300", "66FF00");
  
  // generate min. 10 colors with 30% of not including
  // a gradient. this allows for a greater range of 
  // possible unique combinations
  col.generateColors(10,30);
  
  // if particles already exist, change their color
  if(part!=null) {
    for (int i=0; i<partn; i++) 
      part[i].c=col.getRandomColor();
  }
}

void newMove() {
  stateCount=0;
  stateCountGoal=(int)random(300, 600);

  UVec3 rot=new UVec3(
    random(-1, 1)*0.25+rotXD, random(-1, 1)*0.25+rotYD,0);
  rot.norm(radians(random(0.75f, 1)));
  rot.sub(globalRotX, globalRotY, radD).div(stateCountGoal);

  rotXD=rot.x;
  rotYD=rot.y;

  do {
    radD=random(-0.5f,0.5f);  
    println(globalRad+" "+(globalRad+(float)stateCountGoal*radD));
  } while(globalRad+(float)stateCountGoal*radD>sphereRad*1.25f ||
    globalRad+(float)stateCountGoal*radD<sphereRad*0.6f);
}


