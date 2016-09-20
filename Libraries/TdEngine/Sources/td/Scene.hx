package td;

import kha.Color;
import kha.Image;
import kha.FastFloat;
import kha.math.FastMatrix4;
import kha.Canvas;

class Scene
{
	public var objects:Array<Object>;
	var camera:Camera;
	var light:Light;

	var lightAmbient:FastFloat;
	var bgColor:Color;
	var bgImage:Image;

	public function new():Void
	{
		camera = Camera.get();
		objects = new Array<Object>();

		lightAmbient = 0.005;
		bgColor = Color.Black;
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

	public inline function render(canvas:Canvas):Void
	{
		var g = canvas.g4;

		if (bgImage != null)
		{
			canvas.g2.begin(false);
			canvas.g2.drawScaledSubImage(bgImage, 0, 0, bgImage.width, bgImage.height, 0, 0, Engine.gameWidth, Engine.gameHeight);
			canvas.g2.end();
		}
		else
		{
			g.begin();
			g.clear(bgColor);
		}
		
		for (object in objects)
		{
			object.setMaterialAndBuffers(g);
			
			var mvp = FastMatrix4.identity();
			mvp = mvp.multmat(camera.matrix);
			mvp = mvp.multmat(object.matrix);			
			
			// Send our transformation to the currently bound shader, in the "mvp" uniform
			g.setMatrix(object.material.getConstantLocation('mvp'), mvp);

			if (Engine.lightEnabled && light != null)
				object.material.lightUniforms.update(g, object.shininess, object.specularColor, light, lightAmbient, camera.position);			
			
			g.drawIndexedVertices();
		}

		canvas.g4.end();
	}
}