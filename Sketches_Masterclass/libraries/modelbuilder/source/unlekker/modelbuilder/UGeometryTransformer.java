package unlekker.modelbuilder;

/**
 * Utility class to deal with mesh geometries. It uses the PApplet's <code>beginShape() / vertex() / endShape()</code> to build meshes.
 * A secondary function of the class is to act as a collection of 
 * {@link unlekker.modelbuilder.UVertexList UVertexList} objects, for 
 * instance to perform transformations. 
 *  
 * @author <a href="http://workshop.evolutionzone.com/">Marius Watz</a>
 */

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import processing.core.PApplet;
import processing.core.PConstants;
import unlekker.util.*;

public class UGeometryTransformer implements PConstants {
	public UGeometry old;
	public UGeometry result;
	
	public void extrude(UGeometry obj) {
		
	}

	public void extrude(UGeometry obj,float mod,float ext) {
		UFace f1,f2;
		
		old=obj;
		result=new UGeometry();
		for(int i=0; i<old.quadNum; i++) 
			old.quad[i].extrude(result, mod, ext);
	}

}

