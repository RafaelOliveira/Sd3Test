package objects;

import kha.Assets;
import td.objects.TexObject;

class TexBox extends TexObject
{
	public function new(x:Float = 0, z:Float = 0):Void
	{
		super(Data.texBoxModel, Data.texMaterial, Assets.images.uvplasma);

		position.set(x, 0, z);		
	}
}