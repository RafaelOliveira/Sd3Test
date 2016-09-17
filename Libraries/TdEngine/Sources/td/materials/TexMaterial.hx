package td.materials;

import kha.Shaders;
import kha.graphics4.VertexData;

class TexMaterial extends Material
{
	public function new():Void
	{
		super(Shaders.texture_vert, Shaders.texture_frag);

		bindAttribute('textureCoords', VertexData.Float2);
	}
}