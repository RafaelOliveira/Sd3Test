package td.objects;

import kha.Image;
import kha.graphics4.Graphics;
import kha.graphics4.TextureUnit;
import kha.graphics4.VertexData;

class TexLightObject extends Object
{
	var textureId:TextureUnit;
    var image:Image;

	public function new(data:Array<Float>, indices:Array<Int>, material:Material, image:Image):Void
	{
		material.bindAttribute('textureCoords', VertexData.Float2);
		material.bindAttribute('normals', VertexData.Float3);

		var model = new Model(material);
		model.setVertices(data);
		model.setIndices(indices);

		super(model);

		this.image = image;
		textureId = model.material.getTextureUnit('textureSampler');
	}

	override public function setMaterialAndBuffers(g:Graphics):Void 
	{
		// Uses the vertexBuffer, indexBuffer and pipeline
		super.setMaterialAndBuffers(g);
		
		// Set texture
		g.setTexture(textureId, image);
	}
}