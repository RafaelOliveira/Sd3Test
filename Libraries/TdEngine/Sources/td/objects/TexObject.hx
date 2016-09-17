package td.objects;

import kha.Image;
import kha.graphics4.Graphics;
import kha.graphics4.TextureUnit;

class TexObject extends Object
{	
	var textureId:TextureUnit;
    var image:Image;

	public function new(model:Model, material:Material, image:Image):Void
	{
		super(model, material);						
		
		this.image = image;
		textureId = material.getTextureUnit('textureSampler');
	}
	
	override public function setMaterialAndBuffers(g:Graphics):Void 
	{
		// Uses the vertexBuffer, indexBuffer and pipeline
		super.setMaterialAndBuffers(g);
		
		// Set texture
		g.setTexture(textureId, image);
	}	
}