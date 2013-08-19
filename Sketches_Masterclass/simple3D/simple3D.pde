import unlekker.test.*;
import unlekker.util.*;
import unlekker.modelbuilder.*;
import ec.util.*;

import processing.opengl.*;

UVertexList outline[];
UGeometry geo;
UNav3D nav;

void setup() {
  size(600,600, OPENGL);
  nav=new UNav3D(this);
  nav.setTranslation(width/2,height/2,0);
  
  build();
}

void draw() {
  background(0);
  lights();
  
  nav.doTransforms();
  geo.draw(this);
}
