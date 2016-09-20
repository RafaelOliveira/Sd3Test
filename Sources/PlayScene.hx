package;

import td.Scene;
import kha.Color;
import kha.Assets;
import td.input.Mouse;
import td.input.Keyboard;
import objects.Box;
import objects.Plus3d;

class PlayScene extends Scene
{
	var plus3d:Plus3d;
	var box:Box;
	
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

		//plus3d = new Plus3d(15, 0, 15);
		//add(plus3d);		

		setLight(4, 2, 8, Color.White);
		lightAmbient = 0.5;
		bgImage = Assets.images.bg;
		
		camera.position.set(16, 5, 50);
		//camera.horizontalAngle = 4;
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

		if (Keyboard.isHeld('left'))
			light.position.x -= 0.3;
		else if (Keyboard.isHeld('right'))
			light.position.x += 0.3;

		if (Keyboard.isHeld('up'))
			light.position.z -= 0.3;
		else if (Keyboard.isHeld('down'))
			light.position.z += 0.3;
			
		//plus3d.rotation.y += 3;
	}
}