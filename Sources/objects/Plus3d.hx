package objects;

import kha.Assets;
import sd3.Object;

class Plus3d extends Object
{
	public function new(x:Float = 0, y:Float = 0, z:Float = 0):Void
	{
		super(Data.plus3dModel, Data.material, Assets.images.plus3d);		
		
		position.set(x, y, z);
	}
}