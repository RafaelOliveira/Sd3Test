package;

import sd3.Scene;
import kha.Color;
import kha.Assets;
import sd3.loaders.Loader;
import sd3.input.Mouse;
import sd3.input.Keyboard;
import sd3.Light;
import sd3.collision.RectCollision;
import objects.Box;

class PlayScene extends Scene
{	
	var rotBox:Box;
	var light:Light;

	var collision:RectCollision;	

	public function new():Void
	{
		super();		
		
		Loader.loadModel('box', Assets.blobs.box_obj);

		collision = RectCollision.create();

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
				{					
					var box = add(new Box(x * 2, z * 2));
					collision.add(box, 'boxes');
				}					
			}
		}		

		var sun = Light.fromXYZ(4, 2, 8, Color.White);
		sun.isDirectional = true;		
		addLight(sun);

		//light = Light.fromXYZ(3.5, 0, 3.5, Color.Red);
		//light.ambient = 0.7;
		//addLight(light);
		
		bgImage = Assets.images.bg;		
		
		camera.position.set(3.5, 0, 15);
		camera.rotation.set(0, 3.14, 0);		

		rotBox = cast this.objects[8];		
	}	

	override public function update():Void
	{
		super.update();

		//if (Mouse.isHeld())
		//	camera.updateAngleByMouse(0.005, Mouse.dx, Mouse.dy);			

		if (Keyboard.isHeld('left'))
			camera.rotation.y += 0.05;
		else if (Keyboard.isHeld('right'))
			camera.rotation.y -= 0.05;
		
		if (Keyboard.isHeld('up'))
			camera.moveForward(0.1);			
		else if (Keyboard.isHeld('down'))
			camera.moveBackward(0.1);

		collision.separateArea('boxes', camera.position, 1, 1);		
					
		rotBox.rotation.x += 0.02;
		rotBox.rotation.y += 0.02;
	}
}