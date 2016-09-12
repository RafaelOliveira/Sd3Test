package td;

import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.math.FastVector3;

class Camera
{	
	public static var instance:Camera;

	public var freeMode:Bool;	
		
	public var position:FastVector3;
	public var look:FastVector3;
	public var up:FastVector3;

	public var horizontalAngle:FastFloat;
	public var verticalAngle:FastFloat;

	var direction:FastVector3;
	var rightVector:FastVector3;	
	
	public var projectionMatrix:FastMatrix4;
	public var viewMatrix:FastMatrix4;	
	
	public function new():Void 
	{		
		freeMode = false;

		// Initial horizontal angle: toward -Z
		horizontalAngle = 3.14;
		// Initial vertical angle: none
		verticalAngle = 0.0;		
		
		// Projection matrix: 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
		setProjection(45.0, 4.0 / 3.0, 0.1, 100.0);

		position = new FastVector3(0, 0, 5);
		look = new FastVector3(0, 0, 0);
		up = new FastVector3(0, 1, 0);  
			
		viewMatrix = FastMatrix4.lookAt(
			position,	// position in World Space
			look,		// and looks at the origin
			up			// Head is up (set to (0, -1, 0) to look upside-down)
		);		
		
		instance = this;		
	}
	
	public function update():Void
	{		
		if (!freeMode)
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
			up = rightVector.cross(direction);

			// Look vector
			look = position.add(direction);
		}

		// Camera matrix
		viewMatrix = FastMatrix4.lookAt(position, look, up);				
	}
	
	public function setProjection(fov:FastFloat, ratio:FastFloat, nearPlane:FastFloat, farPlane:FastFloat):Void
	{
		projectionMatrix = FastMatrix4.perspectiveProjection(fov, ratio, nearPlane, farPlane);
	}
	
	public function setView(eye:FastVector3, look:FastVector3, up:FastVector3):Void
	{
		viewMatrix = FastMatrix4.lookAt(eye, look, up);
	}
	
	/**
	 * Move forward in the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function moveForward(value:FastFloat):Void
	{
		var v = direction.mult(value);
		position = position.add(v);		
	}

	/**
	 * Move backward in the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function moveBackward(value:FastFloat):Void 
	{
		var v = direction.mult(value * -1);
		position = position.add(v);		
	}

	/**
	 * Move to the right using the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function strafeRight(value:FastFloat):Void 
	{
		var v = rightVector.mult(value);
		position = position.add(v);		
	}

	/**
	 * Move to the left using the direction defined by 
	 * the horizontal and vertical angles.
	 */
	public function strafeLeft(value:FastFloat):Void 
	{
		var v = rightVector.mult(value * -1);
		position = position.add(v);		
	}

	public function updateAngleByMouse(value:FastFloat, mouseDeltaX:FastFloat, mouseDeltaY:FastFloat):Void
	{		
		horizontalAngle += value * mouseDeltaX * -1;
		verticalAngle += value * mouseDeltaY * -1;		
	}		
}