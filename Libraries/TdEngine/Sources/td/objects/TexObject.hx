package td.objects;

import kha.graphics4.Graphics;
import kha.Image;
import kha.graphics4.TextureUnit;
import kha.graphics4.VertexData;

class TexObject extends Object
{	
	var textureId:TextureUnit;
    var image:Image;

	public function new(vertices:Array<Float>, indices:Array<Int>, textureCoords:Array<Float>, material:Material, image:Image):Void
	{
		material.bindAttribute('textureCoords', VertexData.Float2);

		var model = new Model(material);
		model.setVertices(vertices, [textureCoords]);
		model.setIndices(indices);

		super(model);						
		
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