package sphis.craftbine;

import flixel.math.FlxMath;
import flixel.group.FlxGroup.FlxTypedGroup;
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

		blocks = new FlxTypedGroup<Block>();
		add(blocks);

		var x = 0;
		var y = 0;
        selected_block = Block.BLOCK_LIST[0];
		for (block in Block.BLOCK_LIST)
		{
			var nb = new Block(block, x * 20, y * 20, block ->
			{
				block.hsv_shader.value = 0.5;
                selected_block = block.block_id;
			});

            if (nb.block_id != null)
                blocks.add(nb);
            else 
                continue;

			x++;
            //                                            16.5 won't be 17, it'll be 16. I hope anyway.
			if (x > FlxMath.roundDecimal(FlxG.width / 20, 0))
			{
				x = 0;
				y++;
			}
		}
	}

	var blocks:FlxTypedGroup<Block>;
    var selected_block:String = 'grass_block';
    var selected_ID:Int = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        if (FlxG.keys.anyJustReleased([LEFT, A, RIGHT, D]))
		{
			if (FlxG.keys.anyJustReleased([LEFT, A]))
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

		if (FlxG.keys.justReleased.ESCAPE)
		{
			close();
		}
	}
}
