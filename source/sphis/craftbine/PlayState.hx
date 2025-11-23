package sphis.craftbine;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	var blocks:FlxTypedGroup<Block>;

	var selected_ID:Int = 0;

	override public function create()
	{
		super.create();

		blocks = new FlxTypedGroup<Block>();
		add(blocks);

		var grass_block = new Block().setIconIndex(0);
		var stone_block = new Block().setIconIndex(1);

		grass_block.screenCenter();
		stone_block.screenCenter();
		grass_block.x -= grass_block.width;
		stone_block.x += stone_block.width;

		blocks.add(grass_block);
		blocks.add(stone_block);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.TAB)
		{
			if (FlxG.keys.pressed.SHIFT)
			{
				selected_ID--;
			}
			else
			{
				selected_ID++;
			}

			if (selected_ID < 0)
				selected_ID = 0;

			if (selected_ID > blocks.length)
				selected_ID--;

			for (block in blocks.members)
				block.selected = selected_ID == block.ID;
		}
	}
}
