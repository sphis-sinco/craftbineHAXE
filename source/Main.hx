package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		#if web
		// pixel perfect render fix!
		lime.app.Application.current.window.element.style.setProperty("image-rendering", "pixelated");
		#end

		addChild(new FlxGame(0, 0, PlayState));
	}
}
