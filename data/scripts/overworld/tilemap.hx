// libraries
import flixel.addons.tile.FlxTilemapExt;
import flixel.util.FlxDirectionFlags;
// functions
function create(){
    add(tilemap = new FlxTilemapExt().loadMapFromCSV('data/csv/overworld.csv', Assets.getBitmapData(Paths.image('overworld/plains'), true, false)));
    tilemap.setTileProperties(20, FlxDirectionFlags.ANY, function(tile, object){
        if(marioHB.isTouching(FlxDirectionFlags.FLOOR)){
            if(FlxG.keys.pressed.X){
                marioHB.velocity.y = -marioHB.maxVelocity.y / 1.5;
            }else{
                marioHB.velocity.y = -marioHB.maxVelocity.y / 2;
            }
        }
    });
    tilemap.setDownwardsGlue(true);
}
function update(elapsed){
    FlxG.collide(marioHB, tilemap);
}