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
		FlxG.mouse.enabled = false;

		Block.BLOCK_COUNT = 1;
		Block.DEFAULT_UNSELECTED_FUNCTION = function(block:Block)
		{
			block.hsv_shader.value = 1;
		}
		Block.DEFAULT_SELECTED_FUNCTION = function(block:Block)
		{
			block.hsv_shader.value = 0.5;
			if (FlxG.keys.anyJustReleased([A, LEFT]))
				block.x -= block.width;
			if (FlxG.keys.anyJustReleased([D, RIGHT]))
				block.x += block.width;
			if (FlxG.keys.anyJustReleased([W, UP]))
				block.y -= block.height;
			if (FlxG.keys.anyJustReleased([S, DOWN]))
				block.y += block.height;
		}

		FlxG.switchState(() -> new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
