package td;

import kha.math.FastMatrix4;
import kha.math.FastVector3;
import td.math.Vec3;

class Transform
{
	public var position:Vec3;
	public var rotation:Vec3;
	public var scale:Vec3;

	public var matrix:FastMatrix4;
	public var matrixDirty:Bool;

	public function new():Void
	{
		position = new Vec3(this);
		rotation = new Vec3(this);
		scale = new Vec3(this, 1, 1, 1);

		// Each class that extends Transform creates the matrix
		// in a different way, so the matrix creation is delegated to that class
	}

	public function updateMatrix(position:FastVector3, rotation:FastVector3, scale:FastVector3):Void
	{
		matrix = matrix.multmat(FastMatrix4.scale(scale.x, scale.y, scale.z));
		
		if (rotation.x != 1)
			matrix = matrix.multmat(FastMatrix4.rotationX(rotation.x));

		if (rotation.y != 1)
			matrix = matrix.multmat(FastMatrix4.rotationY(rotation.y));

		if (rotation.z != 1)
			matrix = matrix.multmat(FastMatrix4.rotationZ(rotation.z));

		matrix = matrix.multmat(FastMatrix4.translation(position.x, position.y, position.z));

		matrixDirty = false;
	}
}