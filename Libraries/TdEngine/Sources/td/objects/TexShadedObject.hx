package td.objects;

class TexShadedObject extends Object
{
	var textureId:TextureUnit;
    var image:Image;

	public function new(data:Array<Float>, indices:Array<Int>, image:Image, material:Material):Void
	{
		super(material);
		
		material.bindAttribute('textureCoords', VertexData.Float2);
		material.bindAttribute('normals', VertexData.Float3);
		
		setVertices(data);
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