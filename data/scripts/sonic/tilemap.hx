// libraries
import flixel.addons.tile.FlxTilemapExt;
import flixel.util.FlxDirectionFlags;
// variable
static var tilemap:FlxTilemapExt;
// functions
function create(){
    add(tilemap = new FlxTilemapExt().loadMapFromCSV('data/testZone.csv', Assets.getBitmapData(Paths.image('sonic/tilesets/testZone'), true, false)));
    tilemap.setSlopes([14], [15]);
    tilemap.setDownwardsGlue(true);
}