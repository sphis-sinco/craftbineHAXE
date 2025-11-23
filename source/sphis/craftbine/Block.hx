package sphis.craftbine;

import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var icon_index:Int = 0;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic('assets/images/blocks.png', true, 16, 16);
		// animation.pause();
	}

	public function setIconIndex(index:Int)
	{
		this.icon_index = index;
		this.animation.frameIndex = this.icon_index;
	}
}
