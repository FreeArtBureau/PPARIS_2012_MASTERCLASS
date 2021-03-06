package unlekker.modelbuilder;

import java.awt.event.*;

import controlP5.ControllerInterface;

import processing.core.*;
import unlekker.util.*;

public class UNav3D {
	public PApplet p;
	public UVec3 rot,trans;
	public float rotSpeed=5,transSpeed=5;
	public boolean isParentPApplet=true;
	public boolean shiftIsDown=false;
	
	public UNav3D(PApplet _p) {
		init(_p,true);
	}

	public UNav3D(PApplet _p,boolean _doEvents) { 
		init(_p,_doEvents);
	}
	
	public void init(PApplet _p,boolean _doEvents) {
		p=_p;		
		if(p.getClass().getSimpleName().equals("unlekker.app.App")) isParentPApplet=false;
		rot=new UVec3(0,0,0);
		trans=new UVec3(0,0,0);		
		if(_doEvents) {
		  // code to allow us to use the mouse wheel
			MouseWheelInput mw=new MouseWheelInput();
		  p.addMouseWheelListener(mw);
		  p.registerKeyEvent(this);
		  p.registerMouseEvent(this);
		}
	}

	public void doTransforms() { 
  	p.translate(trans.x,trans.y,trans.z);
  	if(rot.y!=0) p.rotateY(rot.y);
  	if(rot.x!=0) p.rotateX(rot.x);
  	if(rot.z!=0) p.rotateZ(rot.z);
  }
  
	public void keyEvent(KeyEvent ev) {
		if(ev.getID() == KeyEvent.KEY_PRESSED) keyPressed();
		else if(ev.getID() == KeyEvent.KEY_RELEASED) keyReleased();
	}
	
	public void mouseEvent(MouseEvent ev) {
		if (ev.getID() == MouseEvent.MOUSE_DRAGGED) {
			mouseDragged();
		}
	}
	
	public void mouseDragged() {
//		if(isParentPApplet) {
//      rot.y+=p.radians(p.mouseX-p.pmouseX);
//      rot.x+=p.radians(p.mouseY-p.pmouseY);
//      return;
//    }
		
    // if shift is down do pan instead of rotate
    if(shiftIsDown) {
      trans.x+=p.radians(p.mouseX-p.pmouseX)*5*transSpeed;
      trans.y+=p.radians(p.mouseY-p.pmouseY)*5*transSpeed;
    }
    // calculate rot.x and rot.Y by the relative change
    // in mouse position
    else {
      rot.y+=p.radians(p.mouseX-p.pmouseX);
      rot.x+=p.radians(p.mouseY-p.pmouseY);
    }
  }

  public void keyReleased() {
  	if(p.key==p.CODED && p.keyCode==p.SHIFT) {
  		shiftIsDown=false;
//  		UUtil.log("Shift released");
  	}
  }

  public void keyPressed() {
  	if(p.key==p.CODED && p.keyCode==p.SHIFT) {
  		shiftIsDown=true;
//  		UUtil.log("Shift down");
  	}
  	
    if(p.key==p.CODED) {
      // check to see if CTRL is pressed
      if(p.keyEvent.isControlDown()) {
        // do zoom in the Z axis
        if(p.keyCode==p.UP) trans.z+=transSpeed;
        if(p.keyCode==p.DOWN) trans.z-=transSpeed;
        if(p.keyCode==p.LEFT) rot.z+=p.radians(rotSpeed);
        if(p.keyCode==p.RIGHT) rot.z-=p.radians(rotSpeed);
      }
      // check to see if CTRL is pressed
      else if(p.keyEvent.isShiftDown()) {
        // do translations in X and Y axis
        if(p.keyCode==p.UP) trans.y-=transSpeed;
        if(p.keyCode==p.DOWN) trans.y+=transSpeed;
        if(p.keyCode==p.RIGHT) trans.x+=transSpeed;
        if(p.keyCode==p.LEFT) trans.x-=transSpeed;
      }
      else {
        // do rotations around X and Y axis
        if(p.keyCode==p.UP) rot.x+=p.radians(rotSpeed);
        if(p.keyCode==p.DOWN) rot.x-=p.radians(rotSpeed);
        if(p.keyCode==p.RIGHT) rot.y+=p.radians(rotSpeed);
        if(p.keyCode==p.LEFT) rot.y-=p.radians(rotSpeed);
      }
    }
    else {
      if(p.keyEvent.isControlDown()) {
        if(p.keyCode=='R') {
//        	reset();
        }
      }
    }
  }

	public UNav3D reset() {
		p.println("Reset transformations.");
		trans.set(0,0,0);
		rot.set(0,0,0);
	  return this;
	}
  
  public UNav3D setTranslation(UVec3 vv) {
	  trans.set(vv);
	  return this;
  }

  public UNav3D set(UNav3D nv) {
	  trans.set(nv.trans);
	  rot.set(nv.rot);
	  return this;
  }

  public UNav3D setTranslation(float x,float y,float z) {
	  trans.set(x,y,z);
	  return this;
  }

  public UNav3D setRotation(UVec3 vv) {
	  rot.set(vv);
	  return this;
  }

  public UNav3D setRotation(float x,float y,float z) {
	  rot.set(x,y,z);
	  return this;
  }

  public UNav3D addRotation(float x,float y,float z) {
	  rot.add(x,y,z);
	  return this;
  }

  public void mouseWheel(float step) {
    trans.z=trans.z+step*5;
  }
  
  public String toStringData() {
  	return "[UNav3D "+trans.toString()+" "+rot.toString()+"]";
}


	// utility class to handle mouse wheel events
	class MouseWheelInput implements MouseWheelListener{
		public void mouseWheelMoved(MouseWheelEvent e) {
	    mouseWheel(e.getWheelRotation());
	  }
	
	}


	public void interpolate(float camT, UNav3D cam1, UNav3D cam2) {
		UVec3 tD,rD;
		tD=new UVec3(cam2.trans).sub(cam1.trans).mult(camT);
		rD=new UVec3(cam2.rot).sub(cam1.rot).mult(camT);
		
		trans.set(cam1.trans).add(tD);
		rot.set(cam1.rot).add(rD);		
	}

	public void set(String s) {
		UUtil.log("UNav3D.set '"+s+"'");
		String tok[]=p.split(s, ' ');
		trans=UVec3.parse(tok[1]);
		rot=UVec3.parse(tok[2]);
		
//		trans=UVec3.parse("<"+tok[0].substring(0,tok[0].indexOf('>')));
//		rot=UVec3.parse("<"+tok[0].substring(0,tok[0].indexOf('>')));
		// TODO Auto-generated method stub
		
	}
}
