// variable
static var camHUD:FlxCamera = null;
var isSelected:Bool = false;
// functions
function create(){
    // playMenuSong
    CoolUtil.playMenuSong();
    // camera
    FlxG.camera.zoom = 3;
    FlxG.camera.bgColor = 0xff9494ff;
    // importScript
    importScript('data/scripts/smb/mario');
    importScript('data/scripts/smb/tilemap');
    // worldBounds
    FlxG.worldBounds.set(-100000, -100000, 200000, 200000);
    // camHUD
    camHUD = new FlxCamera();
    camHUD.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
}
function update(elapsed){
    // follow
    FlxG.camera.follow(marioHB);
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
    FlxG.collide(marioHB, tilemap);
}