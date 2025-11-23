package sphis.craftbine;

import lime.utils.Assets;
import funkin.graphics.shaders.HSVShader;
import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var icon_index:Int = 0;
	public var block_id:String = null;

	public var selected:Bool = false;
	public var selected_function:Block->Void = null;
	public var unselected_function:Block->Void = null;

	public static var DEFAULT_SELECTED_FUNCTION:Block->Void = null;
	public static var DEFAULT_UNSELECTED_FUNCTION:Block->Void = null;
	public static var BLOCK_COUNT:Int = 0;
	public static var BLOCK_LIST(get, never):Array<String>;

	static function get_BLOCK_LIST():Array<String>
	{
		return Assets.getText('assets/blocks/list.txt').split('\n');
	}

	public var hsv_shader:HSVShader;

	override public function new(?block_id:String, ?x:Float, ?y:Float, ?selected_function:Block->Void, ?unselected_function:Block->Void)
	{
		super(x, y);

		if (block_id != null)
		{
			this.block_id = block_id;

			var block_asset:Array<String> = Assets.getText('assets/blocks/' + block_id + '.txt').split('\n');
			trace(block_asset);

			if ((block_asset[1] ?? 'true').toLowerCase() == 'true') // use_atlas
			{
				loadGraphic('assets/blocks/atlas.png', true, 16, 16);
			}
			else
			{
				//								sub_atlas
				loadGraphic('assets/blocks/' + ((block_asset[2] != null) ? block_asset[2] : block_id) + '.png', true, 16, 16);
			}

			setIconIndex(Std.parseInt(block_asset[0]) ?? 0); // icon_index
		}
		else
		{
			loadGraphic('assets/blocks/atlas.png', true, 16, 16);
		}

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
