package objects;

import kha.Assets;
import sd3.Object;

class Box extends Object
{
	public function new(x:Float, z:Float):Void
	{
		super('box', Assets.images.box);
				
		position.set(x, 0, z);
	}
}