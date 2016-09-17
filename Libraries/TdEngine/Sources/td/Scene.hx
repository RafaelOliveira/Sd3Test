package td;

import kha.FastFloat;
import kha.Color;
import kha.graphics4.Graphics;
import kha.math.FastMatrix4;
import td.objects.Object;

class Scene
{
	public var objects:Array<Object>;
	var camera:Camera;
	var light:Light;

	public function new():Void
	{
		camera = Camera.get();
		objects = new Array<Object>();
	}

	public function update():Void
	{
		for (object in objects)
			object.update();
	}

	public function add(object:Object):Void
	{
		object.scene = this;
		objects.push(object);
	}

	public function remove(object:Object):Void
	{
		object.scene = null;
		objects.remove(object);
	}

	public function setLight(x:FastFloat, y:FastFloat, z:FastFloat, ?color:Color):Void
	{
		light = Light.fromXYZ(x, y, z, color);
	}

	public function removeLight():Void
	{
		light = null;
	}

	public inline function render(g:Graphics):Void
	{
		for (object in objects)
		{
			object.setMaterialAndBuffers(g);
			
			var mvp = FastMatrix4.identity();
			mvp = mvp.multmat(camera.matrix);
			mvp = mvp.multmat(object.matrix);			
			
			// Send our transformation to the currently bound shader, in the "mvp" uniform
			g.setMatrix(object.material.getConstantLocation('mvp'), mvp);

			if (light != null)
			{
				g.setFloat3(object.material.lightPositionId, light.position.x, light.position.y, light.position.z);
				g.setFloat3(object.material.lightColorId, light.color.R, light.color.G, light.color.B);
			}
				
			g.drawIndexedVertices();
		}
	}
}