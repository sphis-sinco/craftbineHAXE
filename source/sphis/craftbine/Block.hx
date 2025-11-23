package sphis.craftbine;

import flixel.FlxG;
import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var icon_index:Int = 0;

	override public function new(?x:Float, ?y:Float)
	{
		super(x, y);

		loadGraphic('assets/images/blocks.png', true, 16, 16);
		// animation.pause();
	}

	public function setIconIndex(index:Int):Block
	{
		this.icon_index = index;
		this.animation.frameIndex = this.icon_index;
		return this;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this) && FlxG.mouse.pressed)
		{
			setPosition(FlxG.mouse.x - (this.width / 2), FlxG.mouse.y - (this.height / 2));
		}
	}
}
