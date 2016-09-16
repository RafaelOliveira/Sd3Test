package td.objects;

class TexLightObject extends Object
{
	var textureId:TextureUnit;
    var image:Image;

	public function new(data:Array<Float>, indices:Array<Int>, material:Material, image:Image):Void
	{
		var model = new Model(material);
		model.setVertices(data);
		model.setIndices(indices);

		super(model);
		
		model.material.bindAttribute('textureCoords', VertexData.Float2);
		model.material.bindAttribute('normals', VertexData.Float3);				

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