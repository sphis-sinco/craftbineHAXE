package sphis.craftbine;

import flixel.FlxState;
import flixel.FlxG;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		#if web
		// pixel perfect render fix!
		lime.app.Application.current.window.element.style.setProperty("image-rendering", "pixelated");
		#end
		FlxG.mouse.visible = false;

		FlxG.switchState(() -> new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
