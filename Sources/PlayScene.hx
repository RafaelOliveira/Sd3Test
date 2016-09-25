package;

import sd3.Scene;
import kha.Color;
import kha.Assets;
import sd3.input.Mouse;
import sd3.input.Keyboard;
import sd3.Light;
import sd3.collision.RectCollision;
import objects.Box;

class PlayScene extends Scene
{	
	var box:Box;
	var light:Light;

	var collision:RectCollision;	

	public function new():Void
	{
		super();		
		
		Data.loadData();

		var places:Array<Array<Int>> = [
			[1, 1, 1, 1, 1],
			[1, 0, 0, 0, 1],
			[1, 0, 1, 0, 1],
			[1, 0, 0, 0, 1],
			[1, 1, 0, 1, 1]
		];

		for (z in 0...places.length)
		{
			for (x in 0...places[z].length)
			{
				if (places[z][x] != 0)
					add(new Box(x * 2, z * 2));
			}
		}		

		var sun = Light.fromXYZ(4, 2, 8, Color.White);
		sun.isDirectional = true;		
		addLight(sun);

		light = Light.fromXYZ(3.5, 0, 3.5, Color.Red);
		light.ambient = 0.7;
		addLight(light);

		//lightAmbient = 0.5;
		bgImage = Assets.images.bg;
		bgColor = 0xff4da6ff;
		
		camera.position.set(3.5, 0, 15);
		//camera.horizontalAngle = 4;

		box = cast this.objects[8];

		collision = RectCollision.set(this);
	}

	override public function update():Void
	{
		super.update();

		if (Mouse.isHeld())
			camera.updateAngleByMouse(0.005, Mouse.dx, Mouse.dy);			

		if (Keyboard.isHeld('a'))			
			camera.moveToLeft(0.2);
		else if (Keyboard.isHeld('d'))			
			camera.moveToRight(0.2);
		
		if (Keyboard.isHeld('w'))			
			camera.moveForward(0.2);			
		else if (Keyboard.isHeld('s'))			
			camera.moveBackward(0.2);

		/*if (Keyboard.isHeld('left'))
			box.position.x -= 0.02;
		else if (Keyboard.isHeld('right'))
			box.position.x += 0.02;

		if (Keyboard.isHeld('up'))
			box.position.z -= 0.02;
		else if (Keyboard.isHeld('down'))
			box.position.z += 0.02;*/

		collision.separateArea(camera.position, 1, 1);		
					
		box.rotation.x += 0.02;
		box.rotation.y += 0.02;
	}
}