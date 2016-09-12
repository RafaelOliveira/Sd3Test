package td;

import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.math.FastVector3;
import td.math.Vec3;
import td.math.Transform;

class Camera
{	
	public static var instance:Camera;

	public var freeMode:Bool;	
		
	public var position:Vec3;
	public var look:Vec3;
	public var up:Vec3;

	public var horizontalAngle(default, set):FastFloat;
	public var verticalAngle(default, set):FastFloat;

	var direction:FastVector3;
	var rightVector:FastVector3;	
	
	public var projectionMatrix:FastMatrix4;

	var viewTransform:Transform;
	public var viewMatrix(get, set):FastMatrix4;
	
	public function new():Void 
	{		
		freeMode = false;

		viewTransform = new Transform();

		// Initial horizontal angle: toward -Z
		horizontalAngle = 3.14;
		// Initial vertical angle: none
		verticalAngle = 0.0;		
		
		// Projection matrix: 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
		setProjection(45.0, 4.0 / 3.0, 0.1, 100.0);		

		position = new Vec3(viewTransform, 0, 0, 5);
		look = new Vec3(viewTransform);
		up = new Vec3(viewTransform, 0, 1, 0);  
			
		/*viewTransform.lookAt(
			position.value,	// position in World Space
			look.value,		// and looks at the origin
			up.value		// Head is up (set to (0, -1, 0) to look upside-down)
		);*/

		viewTransform.dirty = true;
		update();		
		
		instance = this;		
	}
	
	public function update():Void
	{	
		if (viewTransform.dirty)
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
				up.value = rightVector.cross(direction);

				// Look vector
				look.value = position.value.add(direction);										
			}

			// Camera matrix
			viewTransform.lookAt(position.value, look.value, up.value);			
		}
	}	
	
	public function setProjection(fov:FastFloat, ratio:FastFloat, nearPlane:FastFloat, farPlane:FastFloat):Void
	{
		projectionMatrix = FastMatrix4.perspectiveProjection(fov, ratio, nearPlane, farPlane);
	}
	
	public function setView(eye:FastVector3, look:FastVector3, up:FastVector3):Void
	{
		viewTransform.lookAt(eye, look, up);
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
		viewTransform.dirty = true;
	}

	function set_horizontalAngle(value:FastFloat):FastFloat
	{
		viewTransform.dirty = true;
		return horizontalAngle = value;
	}

	function set_verticalAngle(value:FastFloat):FastFloat
	{
		viewTransform.dirty = true;
		return verticalAngle = value;
	}

	inline function get_viewMatrix():FastMatrix4
	{
		return viewTransform.matrix;
	}

	inline function set_viewMatrix(value:FastMatrix4):FastMatrix4
	{		
		return viewTransform.matrix = value;
	} 
}