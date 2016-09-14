package td;

import kha.graphics4.Graphics;
import td.input.Keyboard;
import td.input.Mouse;

class Engine
{	
	var camera:Camera;
	var keyboard:Keyboard;
	var mouse:Mouse;

	var sceneList:Map<String, Scene>;
	var activeScene:Scene;
	
	public function new() 
	{
		keyboard = new Keyboard();
		mouse = new Mouse();
		camera = new Camera();

		sceneList = new Map<String, Scene>();		
		activeScene = null;
	}

	public function addScene(name:String, scene:Scene, setActive:Bool = false):Void
	{
		sceneList.set(name, scene);

		if (setActive)
			activeScene = scene;		
	}

	public function removeScene(name:String):Void
	{
		sceneList.remove(name);
	}

	public function setActiveScene(name:String):Void
	{
		activeScene = sceneList.get(name);
	}
	
	public function update():Void
	{
		keyboard.update();
		mouse.update();
		camera.update();

		if (activeScene != null)
			activeScene.update();

		mouse.postUpdate();
	}
	
	public function render(g:Graphics):Void
	{
		if (activeScene != null)
			activeScene.render(g);				
	}
}