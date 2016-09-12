package;

import kha.Assets;
import kha.Shaders;
import kha.math.FastMatrix4;
import td.Material;
import td.models.SimpleModel;
import td.models.TexturedModel;
import td.Screen;
import td.input.Mouse;
import td.input.Keyboard;

class PlayScreen extends Screen
{
	public function new():Void
	{
		super();

		var indices:Array<Int> = [];
		for (i in 0...Std.int(Data.boxVertices.length / 3))
			indices.push(i);

		var gradientMaterial = new Material(Shaders.gradient_vert, Shaders.gradient_frag);
		var gradientModel = new SimpleModel(Data.boxVertices, indices, gradientMaterial);
		gradientModel.modelMatrix = gradientModel.modelMatrix.multmat(FastMatrix4.translation(5, 0, 0));
		add(gradientModel);
		
		var textureMaterial = new Material(Shaders.texture_vert, Shaders.texture_frag);		
		add(new TexturedModel(Data.boxVertices, indices, Data.boxTextureCoords, Assets.images.uvtemplate, textureMaterial));
	}

	override public function update():Void
	{
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