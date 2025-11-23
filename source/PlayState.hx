package;

import flixel.FlxState;
import sphis.craftbine.Block;

class PlayState extends FlxState
{
	var grass_block:Block;
	var stone_block:Block;

	override public function create()
	{
		super.create();
		grass_block = new Block().setIconIndex(0);
		stone_block = new Block().setIconIndex(1);

		grass_block.screenCenter();
		stone_block.screenCenter();
		grass_block.x -= grass_block.width;
		stone_block.x -= stone_block.width;

		add(grass_block);
		add(stone_block);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
