package td;

import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.math.FastVector3;
import td.math.Vec3;

class Transform
{
	public var position:Vec3;
	public var rotation:Vec3;
	public var scale:Vec3;

	public var forwardDirection:FastVector3;
	public var rightDirection:FastVector3;
	public var upDirection:FastVector3;

	public var matrix:FastMatrix4;
	public var matrixDirty:Bool;

	public function new():Void
	{
		position = new Vec3(this);
		rotation = new Vec3(this);
		scale = new Vec3(this, 1, 1, 1);
		updateDirections();

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

	public function updateDirections():Void
	{
		forwardDirection = new FastVector3(
			Math.cos(rotation.x) * Math.sin(rotation.y),
			Math.sin(rotation.x),
			Math.cos(rotation.x) * Math.cos(rotation.y)
		);

		rightDirection = new FastVector3(
			Math.sin(rotation.y - 3.14 / 2.0), 
			0,
			Math.cos(rotation.y - 3.14 / 2.0)
		);

		upDirection = rightDirection.cross(forwardDirection);
	}

	/**
	 * Move forward using the direction defined in forwardDirection
	 */
	public function moveForward(value:FastFloat):Void
	{
		var v = forwardDirection.mult(value);
		position.value = position.value.add(v);
	}

	/**
	 * Move backward using the direction defined in forwardDirection 
	 */
	public function moveBackward(value:FastFloat):Void 
	{
		var v = forwardDirection.mult(value * -1);
		position.value = position.value.add(v);		
	}

	/**
	 * Move to the right using the direction defined in rightDirection 
	 */
	public function moveToRight(value:FastFloat):Void 
	{
		var v = rightDirection.mult(value);
		position.value = position.value.add(v);		
	}

	/**
	 * Move to the left using the direction defined in rightDirection 
	 */
	public function moveToLeft(value:FastFloat):Void 
	{
		var v = rightDirection.mult(value * -1);
		position.value = position.value.add(v);		
	}
}