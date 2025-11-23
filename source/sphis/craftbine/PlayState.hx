package sphis.craftbine;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	var blocks:FlxTypedGroup<Block>;

	var selected_ID:Int = 0;

	var block_to_place:Block;

	override public function create()
	{
		super.create();

		blocks = new FlxTypedGroup<Block>();
		add(blocks);

		Block.DEFAULT_SELECTED_FUNCTION = function(block:Block)
		{
			InitState.DEFAULT_BLOCK_SELECTED_FUNCTION(block);

			for (other_block in blocks.members)
			{
				if (other_block.ID != block.ID)
				{
					if (block.overlaps(other_block))
					{
						if (FlxG.keys.anyJustReleased([A, LEFT]))
							block.x += block.width;
						if (FlxG.keys.anyJustReleased([D, RIGHT]))
							block.x -= block.width;
						if (FlxG.keys.anyJustReleased([W, UP]))
							block.y += block.height;
						if (FlxG.keys.anyJustReleased([S, DOWN]))
							block.y -= block.height;
					}
				}
			}
		}

		var grass_block = new Block('grass');
		var stone_block = new Block('stone');

		grass_block.x += grass_block.width * 14;
		stone_block.x += stone_block.width * 16;

		grass_block.y += grass_block.height * 12;
		stone_block.y += stone_block.height * 12;

		blocks.add(grass_block);
		blocks.add(stone_block);

		block_to_place = new Block('stone');
		Block.BLOCK_COUNT--;

		block_to_place.x += block_to_place.width * 15;
		block_to_place.y += block_to_place.height * 12;

		block_to_place.hsv_shader.saturation = 2;
		block_to_place.alpha = .5;
		block_to_place.selected_function = function(block:Block)
		{
			InitState.DEFAULT_BLOCK_SELECTED_FUNCTION(block);

			if (FlxG.keys.justReleased.ENTER)
			{
				var overlap:Bool = false;
				var new_block = new Block(block_to_place.block_id, block_to_place.x, block_to_place.y).setIconIndex(block_to_place.icon_index);

				for (block in blocks.members)
					if (new_block.overlaps(block))
						overlap = true;

				if (!overlap)
					blocks.add(new_block);
			}

			if (FlxG.keys.justReleased.DELETE)
			{
				for (block in blocks.members)
					if (block.overlaps(block_to_place))
					{
						blocks.members.remove(block);
						block.destroy();
					}
			}
		};
		add(block_to_place);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		block_to_place.selected = selected_ID == 0;

		if (FlxG.keys.justReleased.ESCAPE)
		{
			openSubState(new BlockSelection());
		}
	}
}
