package models;

import td.models.SimpleModel;
import td.Material;
import kha.Shaders;

class GradBox extends SimpleModel
{
	public function new(x:Float, z:Float):Void
	{
		var material = new Material(Shaders.gradient_vert, Shaders.gradient_frag);

		super(Data.boxVertices, Data.boxIndices, material);

		if (x != 0)
			position.x = x;

		if (z != 0)
			position.z = z;
	}
}