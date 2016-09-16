package td;

import kha.graphics4.Graphics;
import kha.math.FastMatrix4;
import td.objects.Object;

class Scene
{
	public var objects:Array<Object>;
	var camera:Camera;

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

	public inline function render(g:Graphics):Void
	{
		for (object in objects)
		{
			object.setMaterialAndBuffers(g);
			
			var mvp = FastMatrix4.identity();			
			mvp = mvp.multmat(camera.matrix);
			mvp = mvp.multmat(object.matrix);			
			
			// Send our transformation to the currently bound shader, in the "mvp" uniform
			g.setMatrix(object.model.material.getConstantLocation('mvp'), mvp);
				
			g.drawIndexedVertices();
		}
	}
}