package sphis.craftbine;

import flixel.FlxState;
import flixel.FlxG;

class InitState extends FlxState
{
	public static var DEFAULT_BLOCK_SELECTED_FUNCTION = function(block:Block)
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

		if (block.x < 0)
			block.x += block.width;
		if (block.x > FlxG.width - block.width)
			block.x -= block.width - block.width;
		
		if (block.y < 0)
			block.y += block.height;
		if (block.y > FlxG.height - block.height)
			block.y -= block.height - block.height;
	};

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
		Block.DEFAULT_SELECTED_FUNCTION = DEFAULT_BLOCK_SELECTED_FUNCTION;

		FlxG.switchState(() -> new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
