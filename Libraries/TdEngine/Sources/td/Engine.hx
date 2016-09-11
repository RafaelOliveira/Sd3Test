package td;

import kha.graphics4.Graphics;
import kha.math.FastMatrix4;
import kha.math.FastVector3;
import td.input.Keyboard;
import td.input.Mouse;

class Engine
{	
	var camera:Camera;
	var keyboard:Keyboard;
	var mouse:Mouse;

	var screenList:Map<String, Screen>;
	var activeScreen:Screen;
	
	public function new() 
	{
		keyboard = new Keyboard();
		mouse = new Mouse();
		camera = new Camera(new FastVector3(0, 0, 5));

		screenList = new Map<String, Screen>();		
		activeScreen = null;
	}

	public function addScreen(name:String, screen:Screen, setActive:Bool = false):Void
	{
		screenList.set(name, screen);

		if (setActive)
			activeScreen = screen;		
	}

	public function removeScreen(name:String):Void
	{
		screenList.remove(name);
	}

	public function setActiveScreen(name:String):Void
	{
		activeScreen = screenList.get(name);
	}
	
	public function update():Void
	{
		keyboard.update();
		mouse.update();
		camera.update();

		if (activeScreen != null)
			activeScreen.update();
	}
	
	public function render(g:Graphics):Void
	{
		if (activeScreen != null)
		{
			for (model in activeScreen.models)
			{
				model.setMaterialAndBuffers(g);
				
				var mvp = FastMatrix4.identity();
				mvp = mvp.multmat(camera.projectionMatrix);			
				mvp = mvp.multmat(camera.viewMatrix);
				mvp = mvp.multmat(model.modelMatrix);			
				
				// Send our transformation to the currently bound shader, in the "mvp" uniform
				g.setMatrix(model.material.getConstantLocation('mvp'), mvp);
					
				g.drawIndexedVertices();
			}
		}		
	}
}