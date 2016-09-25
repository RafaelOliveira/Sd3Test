package objects;

import kha.Assets;
import sd3.Object;

class Box extends Object
{
	public function new(x:Float, z:Float):Void
	{
		super(Data.boxModel, Data.material, Assets.images.box);
		
		//scale.set(4, 4, 4);
		position.set(x, 0, z);
	}
}