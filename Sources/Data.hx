package;

import kha.Assets;
import kha.Shaders;
import td.Material;
import td.Model;
import td.materials.TexMaterial;
import td.loaders.ObjLoader;

class Data
{
	public static var texMaterial:TexMaterial;	
	public static var boxModel:Model;
	public static var plus3dModel:Model;

	public static function loadData():Void
	{
		texMaterial = new TexMaterial();				

		// plus3d model
		var obj1 = new ObjLoader(Assets.blobs.plus3d_obj.toString());
		plus3dModel = new Model(texMaterial, obj1.data, obj1.indices);

		var obj2 = new ObjLoader(Assets.blobs.box_obj.toString());
		boxModel = new Model(texMaterial, obj2.data, obj2.indices);
	}
}