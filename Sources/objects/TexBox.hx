package objects;

import kha.Assets;
import kha.Shaders;
import td.Material;
import td.objects.TexObject;

class TexBox extends TexObject
{
	public function new(x:Float = 0, z:Float = 0):Void
	{
		var material = new Material(Shaders.texture_vert, Shaders.texture_frag);

		super(Data.boxVertices, Data.boxIndices, Data.boxTextureCoords, material, Assets.images.uvplasma);

		if (x != 0)
			position.x = x;

		if (z != 0)
			position.z = z;
	}
}