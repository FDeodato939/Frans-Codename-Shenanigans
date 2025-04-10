// library
import flixel.text.FlxTextBorderStyle;
// variables
static var characterInfo:FlxText;
var isSelected:Bool = false;
// functions
function create(){
    // camera
    FlxG.camera.zoom = 3;
    FlxG.camera.bgColor = 0xff666666;
    // importScript
    importScript('data/scripts/sonic/sonic');
    importScript('data/scripts/sonic/tilemap');
    // worldBounds
    FlxG.worldBounds.set(-100000, -100000, 200000, 200000);
    // camHUD
    camHUD = new FlxCamera();
    camHUD.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
    // characterInfo
    add(characterInfo = new FlxText(0, 0, FlxG.width, 'NULL', 12));
    characterInfo.alignment = 'right';
    characterInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    characterInfo.borderSize = 3;
    characterInfo.cameras = [camHUD];
}
function update(elapsed){
    // sonicHB
    FlxG.camera.follow(sonicHB);
    // isSelected
    if(!isSelected){
        if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // state
            FlxG.switchState(new MainMenuState());
            // isSelected
            isSelected = true;
        }
    }
    // collide
    FlxG.collide(sonicHB, tilemap);
}