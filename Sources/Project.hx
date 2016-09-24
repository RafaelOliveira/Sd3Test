package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
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
		engine = new Engine({ backbuffer: false, backbufferWidth: 800, backbufferHeight: 600, lights: true });
		engine.addScene('play', new PlayScene(), true);

		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update():Void
	{
		engine.update();		
	}

	function render(fb:Framebuffer):Void 
	{				
		engine.render(fb);
	}
}