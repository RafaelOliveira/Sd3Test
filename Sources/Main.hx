package;

import kha.System;

class Main 
{
	static inline var WIDTH:Int = 800;
	static inline var HEIGHT:Int = 600;

	public static function main() 
	{
		System.init({ title: '3DEngine', width: WIDTH, height: HEIGHT }, function () {
			new Project();
		});
	}
}
