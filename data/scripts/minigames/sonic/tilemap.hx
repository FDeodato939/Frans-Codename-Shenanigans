// libraries
import flixel.addons.tile.FlxTilemapExt;
import flixel.graphics.frames.FlxTileFrames;
import flixel.util.FlxDirectionFlags;
// functions
function create(){
    add(tilemap = new FlxTilemapExt().loadMapFromCSV('data/csv/sonic.csv', Assets.getBitmapData(Paths.image('minigames/sonic/tiles/liner'), true, false)));
    tilemap.setSlopes([13, 15, 16, 19, 21], [14, 17, 18, 20, 22]);
    tilemap.setGentle([16, 17], [15, 18]);
    tilemap.setSteep([19, 20], [21, 22]);
    tilemap.setDownwardsGlue(true);
}
function postUpdate(elapsed){
    FlxG.collide(sonicHB, tilemap);
    FlxG.collide(motobugHBGroup, tilemap);
}