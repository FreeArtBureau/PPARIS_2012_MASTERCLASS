void record() {
  if(sndData==null) {
    sndData=new ArrayList();
  }
  
  textFont(fnt);
  textAlign(CENTER);
  fill(255);
  text("Recording... "+sndData.size()+" / "+(int)(30*(recDuration/1000)), width/2,height/2);
  
  fft.forward(player.mix);
  
  float snd[]=new float[fftSize];
  for (int i = 0; i < fftSize; i++) snd[i] = fft.getAvg(i));

  sndData.add(new SpectrumFrame(snd));
}

class SpectrumFrame {
  float data[];
  float maxLevel;
  UVertexList vl;
  boolean isNormalized=false;

  SpectrumFrame(float _data[]) {
    data=_data;
    for(int i=0; i<data.length; i++) maxLevel=max(maxLevel,data[i]);
  }

  void normalize() {
    if(isNormalized) return; // only normalize once
    for(int i=0; i<data.length; i++) data[i]/=globalMaxLevel;
    isNormalized=true;
  }
  
  void build() {
    vl=new UVertexList();
    for(int i=0; i<data.length; i++) vl.add(i,data[i],0);    
    vl.scale(xScale,ampl,1);
  }
}
