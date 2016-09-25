package;

import kha.Assets;
import sd3.Model;
import sd3.materials.Material;

class Data
{		
	public static var boxModel:Model;
	public static var plus3dModel:Model;
	public static var material:Material;

	public static function loadData():Void
	{
		material = Material.get();
		plus3dModel = Model.load(material, Assets.blobs.plus3d_obj);		
		boxModel = Model.load(material, Assets.blobs.box_obj);
	}
}