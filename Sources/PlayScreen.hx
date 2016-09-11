package;

import kha.Assets;
import td.Material;
import kha.Shaders;
import td.models.SimpleModel;
import td.models.TexturedModel;
import td.Screen;
import td.input.Mouse;

class PlayScreen extends Screen
{
	public function new():Void
	{
		super();

		var indices:Array<Int> = [];
		for (i in 0...Std.int(Data.boxVertices.length / 3))
			indices.push(i);

		//var gradientMaterial = new Material(Shaders.gradient_vert, Shaders.gradient_frag);
		//models.push(new SimpleModel(vertices, indices, gradientMaterial));
		
		var textureMaterial = new Material(Shaders.texture_vert, Shaders.texture_frag);		
		add(new TexturedModel(Data.boxVertices, indices, Data.boxTextureCoords, Assets.images.uvtemplate, textureMaterial));
	}

	override public function update():Void
	{
		if (Mouse.isPressed())		
			camera.updateDirectionByMouse(0.005, Mouse.dx, Mouse.dy);		
	}
}