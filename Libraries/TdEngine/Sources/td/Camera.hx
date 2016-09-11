package td;

import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.math.FastVector3;

class Camera
{	
	public static var instance:Camera;
		
	public var position:FastVector3;
	public var direction:FastVector3;
	public var horizontalAngle(default, set):FastFloat;
	public var verticalAngle(default, set):FastFloat;	
	public var look:FastVector3;
	public var up:FastVector3;

	var rightVector:FastVector3;
	var updateDirectionByAngle:Bool;
	
	public var projectionMatrix:FastMatrix4;
	public var viewMatrix:FastMatrix4;	
	
	public function new(position:FastVector3, ?look:FastVector3, ?up:FastVector3):Void 
	{		
		// Initial horizontal angle: toward -Z
		horizontalAngle = 3.14;
		// Initial vertical angle: none
		verticalAngle = 0.0;

		updateDirectionByAngle = true;
		
		// Projection matrix: 45° Field of View, 4:3 ratio, display range : 0.1 unit <-> 100 units
		setProjection(45.0, 4.0 / 3.0, 0.1, 100.0);

		this.position = position;
		this.look = look != null ? look : new FastVector3(0, 0, 0);
		this.up = up != null ? up : new FastVector3(0, 1, 0);  
			
		viewMatrix = FastMatrix4.lookAt(
			this.position,	// position in World Space
			this.look,		// and looks at the origin
			this.up			// Head is up (set to (0, -1, 0) to look upside-down)
		);
		
		instance = this;		
	}
	
	public function update():Void
	{		
		if (updateDirectionByAngle)
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

			updateDirectionByAngle = false;
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
	
	public function moveForward(speed:FastFloat):Void
	{
		var v = direction.mult(speed);
		position = position.add(v);
	}

	public function moveBackward(speed:FastFloat):Void 
	{
		var v = direction.mult(speed * -1);
		position = position.add(v);
	}

	public function strafeRight(speed:FastFloat):Void 
	{
		var v = rightVector.mult(speed);
		position = position.add(v);
	}

	public function strafeLeft(speed:FastFloat):Void 
	{
		var v = rightVector.mult(speed * -1);
		position = position.add(v);
	}

	public function updateDirectionByMouse(speed:FastFloat, mouseDeltaX:FastFloat, mouseDeltaY:FastFloat):Void
	{		
		horizontalAngle += speed * mouseDeltaX * -1;
		verticalAngle += speed * mouseDeltaY * -1;
		updateDirectionByAngle = true;
	}
	
	function set_horizontalAngle(value:FastFloat):FastFloat
	{
		updateDirectionByAngle = true;
		
		return horizontalAngle = value;
	}
	
	function set_verticalAngle(value:FastFloat):FastFloat
	{
		updateDirectionByAngle = true;
		
		return verticalAngle = value;
	}	
}