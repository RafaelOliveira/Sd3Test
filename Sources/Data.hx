package;

import kha.Assets;
import kha.Shaders;
import td.Material;
import td.Model;
import td.materials.TexMaterial;
import td.materials.TexLightMaterial;
import td.loaders.ObjLoader;

class Data
{
	public static var boxTextureCoords:Array<Float> = [
		0.000059, 0.000004, 
		0.000103, 0.336048, 
		0.335973, 0.335903, 
		1.000023, 0.000013, 
		0.667979, 0.335851, 
		0.999958, 0.336064, 
		0.667979, 0.335851, 
		0.336024, 0.671877, 
		0.667969, 0.671889, 
		1.000023, 0.000013, 
		0.668104, 0.000013, 
		0.667979, 0.335851, 
		0.000059, 0.000004, 
		0.335973, 0.335903, 
		0.336098, 0.000071, 
		0.667979, 0.335851, 
		0.335973, 0.335903, 
		0.336024, 0.671877, 
		1.000004, 0.671847, 
		0.999958, 0.336064, 
		0.667979, 0.335851, 
		0.668104, 0.000013, 
		0.335973, 0.335903, 
		0.667979, 0.335851, 
		0.335973, 0.335903,
		0.668104, 0.000013, 
		0.336098, 0.000071, 
		0.000103, 0.336048, 
		0.000004, 0.671870, 
		0.336024, 0.671877, 
		0.000103, 0.336048, 
		0.336024, 0.671877, 
		0.335973, 0.335903, 
		0.667969, 0.671889, 
		1.000004, 0.671847, 
		0.667979, 0.335851
	];
	
	public static var boxVertices:Array<Float> = [
		-1.0,-1.0,-1.0,
		-1.0,-1.0, 1.0,
		-1.0, 1.0, 1.0,
		1.0, 1.0,-1.0,
		-1.0,-1.0,-1.0,
		-1.0, 1.0,-1.0,
		1.0,-1.0, 1.0,
		-1.0,-1.0,-1.0,
		1.0,-1.0,-1.0,
		1.0, 1.0,-1.0,
		1.0,-1.0,-1.0,
		-1.0,-1.0,-1.0,
		-1.0,-1.0,-1.0,
		-1.0, 1.0, 1.0,
		-1.0, 1.0,-1.0,
		1.0,-1.0, 1.0,
		-1.0,-1.0, 1.0,
		-1.0,-1.0,-1.0,
		-1.0, 1.0, 1.0,
		-1.0,-1.0, 1.0,
		1.0,-1.0, 1.0,
		1.0, 1.0, 1.0,
		1.0,-1.0,-1.0,
		1.0, 1.0,-1.0,
		1.0,-1.0,-1.0,
		1.0, 1.0, 1.0,
		1.0,-1.0, 1.0,
		1.0, 1.0, 1.0,
		1.0, 1.0,-1.0,
		-1.0, 1.0,-1.0,
		1.0, 1.0, 1.0,
		-1.0, 1.0,-1.0,
		-1.0, 1.0, 1.0,
		1.0, 1.0, 1.0,
		-1.0, 1.0, 1.0,
		1.0,-1.0, 1.0
	];

	public static var boxIndices:Array<Int> = [];

	public static var gradientMaterial:Material;
	public static var texMaterial:TexMaterial;
	public static var texLightMaterial:TexLightMaterial;

	public static var gradientBoxModel:Model;
	public static var texBoxModel:Model;
	public static var plus3dModel:Model;

	public static function loadData():Void
	{
		// box indices
		for (i in 0...Std.int(boxVertices.length / 3))
			boxIndices.push(i);

		// materials
		gradientMaterial = new Material(Shaders.gradient_vert, Shaders.gradient_frag);
		texMaterial = new TexMaterial();
		texLightMaterial = new TexLightMaterial();		

		// box models
		gradientBoxModel = new Model(gradientMaterial, boxVertices, boxIndices);
		texBoxModel = new Model(texMaterial, boxVertices, boxIndices, [boxTextureCoords]);		

		// plus3d model
		var obj = new ObjLoader(Assets.blobs.plus3d_obj.toString());
		plus3dModel = new Model(texLightMaterial, obj.data, obj.indices);		
	}
}