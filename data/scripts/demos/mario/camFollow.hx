// libraries
import flixel.util.FlxDirectionFlags;
// functions
function create(){
    add(marioCamFollow = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT));
}
function update(elapsed){
    // camera
    FlxG.camera.follow(marioCamFollow);
    // marioCamFollow
    marioCamFollow.setPosition(lerp(marioCamFollow.x, marioHB.x, 0.1), lerp(marioCamFollow.y, marioHB.y, 0.1));
}