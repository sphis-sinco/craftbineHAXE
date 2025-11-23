package sphis.craftbine;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class BlockSelection extends FlxSubState
{
	var bg:FlxSprite;

	override function create()
	{
		super.create();

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height);
		bg.alpha = .5;
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ESCAPE)
			close();
	}
}
