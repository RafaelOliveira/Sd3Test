package td;

import kha.Canvas;
import kha.System;
import td.input.Keyboard;
import td.input.Mouse;

class Engine
{	
	var camera:Camera;
	var keyboard:Keyboard;
	var mouse:Mouse;

	var sceneList:Map<String, Scene>;
	var activeScene:Scene;
	
	public static var gameWidth:Int;
	public static var gameHeight:Int;

	public function new() 
	{
		gameWidth = System.windowWidth();
		gameHeight = System.windowHeight();

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
	
	public function render(canvas:Canvas):Void
	{
		if (activeScene != null)
			activeScene.render(canvas);				
	}
}