package td.models;

import kha.graphics4.Graphics;
import kha.Image;
import kha.graphics4.TextureUnit;
import kha.graphics4.VertexData;

class TexturedModel extends Model
{	
	var textureId:TextureUnit;
    var image:Image;

	public function new(vertices:Array<Float>, indices:Array<Int>, textureCoords:Array<Float>, image:Image, material:Material):Void
	{
		super(material);
		
		material.bindAttribute('textureCoords', VertexData.Float2);		
		
		setVerticesAndTextureCoords(vertices, textureCoords);
		setIndices(indices);		

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