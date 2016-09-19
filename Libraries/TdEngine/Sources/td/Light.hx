package td;

import kha.FastFloat;
import kha.Color;
import kha.math.Vector3;

class Light
{
	public var position:Vector3;
	public var color:Color;
	public var attenuation:FastFloat;

	public function new(position:Vector3, ?color:Color):Void
	{
		this.position = position;
		this.color = color != null ? color : Color.White;
		attenuation = 0.2;
	}

	public static function fromXYZ(x:FastFloat, y:FastFloat, z:FastFloat, ?color:Color):Light
	{
		return new Light(new Vector3(x, y, z), color != null ? color : Color.White);
	}
}