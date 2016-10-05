package;

import kha.System;
import sd3.Engine;

class Main 
{
	static inline var WIDTH:Int = 800;
	static inline var HEIGHT:Int = 600;

	public static function main()
	{
		#if js
		Engine.setupMobileBrowser();
		#end

		System.init({ title: '3DEngine', width: WIDTH, height: HEIGHT }, function () {
			new Project();
		});
	}
}
