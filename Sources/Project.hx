package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import sd3.Engine;

class Project 
{
	var engine:Engine;	

	public function new():Void 
	{
		Assets.loadEverything(assetsLoaded);
	}

	function assetsLoaded():Void
	{		
		engine = new Engine({ lightLevel: 3 });
		engine.addScene('play', new PlayScene(), true);

		System.notifyOnRender(engine.render);
		Scheduler.addTimeTask(engine.update, 0, 1 / 60);
	}	
}