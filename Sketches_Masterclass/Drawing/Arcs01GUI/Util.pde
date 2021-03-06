public String getIncrementalFilename(String what) {
  String s="",prefix,suffix,padstr,numstr;
  int index=0,first,last,count;
  File f;
  boolean ok;

  first=what.indexOf('#');
  last=what.lastIndexOf('#');
  count=last-first+1;

  if( (first!=-1)&& (last-first>0)) {
    prefix=what.substring(0, first);
    suffix=what.substring(last+1);

    // Comment out if you want to use absolute paths
    // or if you're not using this inside PApplet
    if(sketchPath!=null) prefix=savePath(prefix);

    index=0;
    ok=false;

    do {
      padstr="";
      numstr=""+index;
      for(int i=0; i< count-numstr.length(); i++) padstr+="0";
      s=prefix+padstr+numstr+suffix;

      f=new File(s);
      ok=!f.exists();
      index++;

      // Provide a panic button. If index > 10000 chances are it’s an
      // invalid filename.
      if(index>10000) ok=true;

    }
    while(!ok);

    // Panic button - comment out if you know what you’re doing
    if(index> 10000) {
      println("getIncrementalFilename thinks there is a problem - "+
        "Is there  more than 10000 files already in the sequence "+
        " or is the filename invalid?");
      println("Returning "+prefix+"ERR"+suffix);
      return prefix+"ERR"+suffix;
    }
  }

  return s;
}


