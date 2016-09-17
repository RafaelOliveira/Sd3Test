package objects;

import td.objects.Object;

class GradBox extends Object
{
	public function new(x:Float, z:Float):Void
	{
		super(Data.gradientBoxModel, Data.gradientMaterial);
		
		position.set(x, 0, z);		
	}
}