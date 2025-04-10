// libraries
import flixel.addons.tile.FlxTilemapExt;
import flixel.util.FlxDirectionFlags;
// variable
static var tilemap:FlxTilemapExt;
// functions
function create(){
    add(tilemap = new FlxTilemapExt().loadMapFromCSV('data/smbMap.csv', Assets.getBitmapData(Paths.image('smb/tileset'), true, false)));
    tilemap.setDownwardsGlue(true);
}