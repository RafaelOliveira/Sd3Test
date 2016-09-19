package objects;

import kha.Assets;
import td.objects.TexObject;

class Box extends TexObject
{
	public function new(x:Float, z:Float):Void
	{
		super(Data.boxModel, Data.texMaterial, Assets.images.box);
		
		scale.set(4, 4, 4);
		position.set(x, 0, z);
	}
}