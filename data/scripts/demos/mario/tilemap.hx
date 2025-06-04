// libraries
import flixel.addons.tile.FlxTilemapExt;
import flixel.util.FlxDirectionFlags;
// functions
function create(){
    add(tilemap = new FlxTilemapExt().loadMapFromCSV('data/csv/mario.csv', Assets.getBitmapData(Paths.image('demos/mario/tiles'), true, false)));
    tilemap.setDownwardsGlue(true);
}
function postUpdate(elapsed){
    FlxG.collide(marioHB, tilemap);
}