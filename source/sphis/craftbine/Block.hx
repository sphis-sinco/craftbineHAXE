package sphis.craftbine;

import funkin.graphics.shaders.HSVShader;
import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var icon_index:Int = 0;

	public var selected:Bool = false;
	public var selected_function:Block->Void = null;
	public var unselected_function:Block->Void = null;

	public static var DEFAULT_SELECTED_FUNCTION:Block->Void = null;
	public static var DEFAULT_UNSELECTED_FUNCTION:Block->Void = null;
	public static var BLOCK_COUNT:Int = 0;

	public var hsv_shader:HSVShader;

	override public function new(?x:Float, ?y:Float, ?selected_function:Block->Void, ?unselected_function:Block->Void)
	{
		super(x, y);

		loadGraphic('assets/images/blocks.png', true, 16, 16);
		// animation.pause();

		this.selected_function = selected_function ?? DEFAULT_SELECTED_FUNCTION;
		this.unselected_function = unselected_function ?? DEFAULT_UNSELECTED_FUNCTION;

		this.setID(Block.BLOCK_COUNT);
		Block.BLOCK_COUNT += 1;

		hsv_shader = new HSVShader(1, 1, 1);
		this.shader = hsv_shader;
	}

	public function setIconIndex(index:Int):Block
	{
		this.icon_index = index;
		this.animation.frameIndex = this.icon_index;

		return this;
	}

	public function setID(ID:Int):Block
	{
		this.ID = ID;
		return this;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (selected)
		{
			if (selected_function != null)
				selected_function(this);
		}
		else
		{
			if (unselected_function != null)
				unselected_function(this);
		}
	}
}
