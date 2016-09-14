package td;

import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.math.FastVector3;
import td.math.Vec3;

class Camera extends Transform
{	
	static var instance:Camera;
	
	public var look:Vec3;
	public var up:Vec3;

	public var horizontalAngle(default, set):FastFloat;
	public var verticalAngle(default, set):FastFloat;

	var direction:FastVector3;
	var rightVector:FastVector3;	
	
	public var projectionMatrix:FastMatrix4;
	
	public function new():Void 
	{
		super();

		// Initial horizontal angle: toward -Z
		horizontalAngle = 3.14;
		// Initial vertical angle: none
		verticalAngle = 0.0;		
		
		// Projection matrix: 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
		setProjection(45.0, 4.0 / 3.0, 0.1, 100.0);		

		position.set(0, 0, 25);
		look = new Vec3(this);
		up = new Vec3(this, 0, 1, 0);  
			
		matrix = FastMatrix4.lookAt(
			position.value,	// position in World Space
			look.value,		// and looks at the origin
			up.value		// Head is up (set to (0, -1, 0) to look upside-down)
		);

		//matrix = FastMatrix4.identity();
		//matrix = matrix.multmat(FastMatrix4.perspectiveProjection(45.0, 4.0 / 3.0, 0.1, 100.0));
		//matrix = matrix.multmat(FastMatrix4.lookAt(position.value, look.value, up.value));
		matrixDirty = false;

		//matrixDirty = true;
		//update();
		
		instance = this;
	}
	
	public function update():Void
	{	
		if (matrixDirty)
		{			
			// Direction : Spherical coordinates to Cartesian coordinates conversion
			direction = new FastVector3(
				Math.cos(verticalAngle) * Math.sin(horizontalAngle),
				Math.sin(verticalAngle),
				Math.cos(verticalAngle) * Math.cos(horizontalAngle)
			);			

			rightVector = new FastVector3(
				Math.sin(horizontalAngle - 3.14 / 2.0), 
				0,
				Math.cos(horizontalAngle - 3.14 / 2.0)
			);

			// Up vector
			up.value = rightVector.cross(direction);

			// Look vector
			look.value = position.value.add(direction);			

			// Camera matrix
			matrix = FastMatrix4.lookAt(position.value, look.value, up.value);
			matrixDirty = false;			
		}
	}	
	
	public function setProjection(fov:FastFloat, ratio:FastFloat, nearPlane:FastFloat, farPlane:FastFloat):Void
	{
		projectionMatrix = FastMatrix4.perspectiveProjection(fov, ratio, nearPlane, farPlane);
	}
	
	public function setView(position:FastVector3, look:FastVector3, up:FastVector3):Void
	{
		this.position.value = position;
		this.look.value = look;
		this.up.value = up;

		direction = position.sub(look);
		direction.normalize();		

		matrix = FastMatrix4.lookAt(position, look, up);
		matrixDirty = false;
	}
	
	/**
	 * Move forward in the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function moveForward(value:FastFloat):Void
	{
		var v = direction.mult(value);
		position.value = position.value.add(v);		
	}

	/**
	 * Move backward in the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function moveBackward(value:FastFloat):Void 
	{
		var v = direction.mult(value * -1);
		position.value = position.value.add(v);		
	}

	/**
	 * Move to the right using the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function strafeRight(value:FastFloat):Void 
	{
		var v = rightVector.mult(value);
		position.value = position.value.add(v);		
	}

	/**
	 * Move to the left using the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function strafeLeft(value:FastFloat):Void 
	{
		var v = rightVector.mult(value * -1);
		position.value = position.value.add(v);		
	}

	public function updateAngleByMouse(value:FastFloat, mouseDeltaX:FastFloat, mouseDeltaY:FastFloat):Void
	{		
		horizontalAngle += value * mouseDeltaX * -1;
		verticalAngle += value * mouseDeltaY * -1;
		matrixDirty = true;
	}

	public static function get():Camera
	{
		return instance;
	}

	function set_horizontalAngle(value:FastFloat):FastFloat
	{
		matrixDirty = true;
		return horizontalAngle = value;
	}

	function set_verticalAngle(value:FastFloat):FastFloat
	{
		matrixDirty = true;
		return verticalAngle = value;
	}	 
}