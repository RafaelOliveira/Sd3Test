package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha.Color;
import td.Engine;

class Project 
{
	var engine:Engine;	

	public function new():Void 
	{
		Assets.loadEverything(assetsLoaded);
	}

	function assetsLoaded():Void
	{		
		engine = new Engine();
		engine.addScreen('play', new PlayScreen(), true); 		

		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update():Void 
	{
		engine.update();		
	}    

	function render(fb:Framebuffer):Void 
	{
		var g = fb.g4;

		g.begin();
		g.clear(Color.Black);

		engine.render(g);

		g.end();
	}
}