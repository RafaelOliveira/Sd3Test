package;

import kha.math.FastVector3;
import td.Scene;
import td.input.Mouse;
import td.input.Keyboard;
import objects.GradBox;
import objects.TexBox;

class PlayScene extends Scene
{
	public function new():Void
	{
		super();
		
		Data.fillBoxIndices();

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
					var r = Math.random();
					var px = x * 2;
					var pz = z * 2;

					if (r < 0.5)
						add(new GradBox(px, pz));
					else
						add(new TexBox(px, pz));
				}
			}
		}				

		camera.setView(new FastVector3(0, 20, 20), new FastVector3(), new FastVector3(0, 1, 0));
		//camera.position.x = 5;
		//camera.position.z = 15;
	}

	override public function update():Void
	{
		super.update();

		if (Mouse.isHeld())		
			camera.updateAngleByMouse(0.005, Mouse.dx, Mouse.dy);

		if (Keyboard.isHeld('a'))
			camera.strafeLeft(0.1);
		else if (Keyboard.isHeld('d'))
			camera.strafeRight(0.1);

		if (Keyboard.isHeld('w'))
			camera.moveForward(0.1);
		else if (Keyboard.isHeld('s'))
			camera.moveBackward(0.1);
	}
}