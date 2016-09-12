package td.math;

import kha.math.FastMatrix4;
import kha.math.FastVector3;

class Transform
{
	public var dirty:Bool;
	public var matrix:FastMatrix4;

	public function new():Void
	{
		matrix = FastMatrix4.identity();
		dirty = false;
	}

	public inline function lookAt(eye:FastVector3, look:FastVector3, up:FastVector3):Void
	{
		matrix = FastMatrix4.lookAt(eye, look, up);
		dirty = false;
	}

	public inline function updateTransformation(position:FastVector3, rotation:FastVector3, scale:FastVector3):Void
	{
		matrix = matrix.multmat(FastMatrix4.scale(scale.x, scale.y, scale.z));
		
		if (rotation.x != 1)
			matrix = matrix.multmat(FastMatrix4.rotationX(rotation.x));

		if (rotation.y != 1)
			matrix = matrix.multmat(FastMatrix4.rotationY(rotation.y));

		if (rotation.z != 1)
			matrix = matrix.multmat(FastMatrix4.rotationZ(rotation.z));

		matrix = matrix.multmat(FastMatrix4.translation(position.x, position.y, position.z));
		dirty = false;
	}
}