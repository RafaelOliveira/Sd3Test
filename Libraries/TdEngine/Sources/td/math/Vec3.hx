package td.math;

import kha.math.FastVector3;
import kha.FastFloat;

class Vec3
{
	public var value(default, set):FastVector3;
	public var transform:Transform;

	public var x(get, set):FastFloat;
	public var y(get, set):FastFloat;
	public var z(get, set):FastFloat;

	public var dirty:Bool;

	public function new(transform:Transform, x:FastFloat = 0, y:FastFloat = 0, z:FastFloat = 0):Void
	{	
		this.transform = transform;	
		value = new FastVector3(x, y, z);		
	}

	function set_value(value:FastVector3):FastVector3
	{
		transform.dirty = true;
		return this.value = value;
	}

	inline function get_x():FastFloat
	{
		return value.x;
	}

	function set_x(value:FastFloat):FastFloat
	{
		transform.dirty = true;
		return this.value.x = value;
	}

	inline function get_y():FastFloat
	{
		return value.y;
	}

	function set_y(value:FastFloat):FastFloat
	{
		transform.dirty = true;
		return this.value.y = value;
	}

	inline function get_z():FastFloat
	{
		return value.z;
	}

	function set_z(value:FastFloat):FastFloat
	{
		transform.dirty = true;
		return this.value.z = value;
	}
}