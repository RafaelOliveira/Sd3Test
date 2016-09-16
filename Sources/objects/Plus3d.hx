package objects;

import kha.Assets;
import kha.Shaders;
import td.Material;
import td.objects.TexLightObject;
import td.loaders.ObjLoader;

class Plus3d extends TexLightObject
{
	public function new(x:Float = 0, y:Float = 0, z:Float = 0):Void
	{
		var obj = new ObjLoader(Assets.blobs.plus3d_obj.toString());
		var data = obj.data;
    	var indices = obj.indices;

		var material = new Material(Shaders.texture_vert, Shaders.texture_frag);

		super(data, indices, material, Assets.images.plus3d);

		scale.multByScalar(0.7);
		
		position.x = x;
		position.y = y;		
		position.z = z;		
	}
}