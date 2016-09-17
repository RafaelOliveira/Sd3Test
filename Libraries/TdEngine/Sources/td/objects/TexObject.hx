package td.objects;

import kha.Image;
import kha.graphics4.Graphics;
import td.materials.TexMaterial;

class TexObject extends Object
{		
    var image:Image;	

	public function new(model:Model, material:TexMaterial, image:Image):Void
	{
		super(model, material);						
		
		this.image = image;		
	}
	
	override public function setMaterialAndBuffers(g:Graphics):Void 
	{
		// Uses the vertexBuffer, indexBuffer and pipeline
		super.setMaterialAndBuffers(g);
		
		// Set texture
		g.setTexture(material.textureId, image);	
	}	
}