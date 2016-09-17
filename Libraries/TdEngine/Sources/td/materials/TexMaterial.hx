package td.materials;

import kha.Shaders;
import kha.graphics4.VertexData;

class TexMaterial extends Material
{
	public function new():Void
	{
		super(Shaders.texture_pf_light_vert, Shaders.texture_pf_light_frag);

		bindAttribute('textureCoord', VertexData.Float2);
		bindAttribute('normal', VertexData.Float3);

		textureId = getTextureUnit('textureSampler');
	}	
}