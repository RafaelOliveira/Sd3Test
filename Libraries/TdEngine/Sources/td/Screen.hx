package td;

import td.models.Model;

class Screen
{
	public var models:Array<Model>;
	var camera:Camera;

	public function new():Void
	{
		camera = Camera.instance;
		models = new Array<Model>();
	}

	public function update():Void
	{

	}

	public function add(model:Model):Void
	{
		models.push(model);
	}

	public function remove(model:Model):Void
	{
		models.remove(model);
	}
}