// variables
static var marioCam:FlxCamera;
var isSelected:Bool = false;
// functions
function create(){
    // camera
    FlxG.camera.zoom = 3;
    FlxG.camera.bgColor = 0xff000000;
    // importScript
    importScript('data/scripts/demos/mario/backdrop');
    importScript('data/scripts/demos/mario/camFollow');
    importScript('data/scripts/demos/mario/mario');
    importScript('data/scripts/demos/mario/tilemap');
    importScript('data/scripts/demos/mario/hud');
    // worldBounds
    FlxG.worldBounds.set(-100000, -100000, 200000, 200000);
    // marioCam
    marioCam = new FlxCamera();
    marioCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(marioCam, false);
}
function update(elapsed){
    if(!isSelected){
        if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // state
            new FlxTimer().start(0.25, function(){FlxG.switchState(new MainMenuState());});
            // isSelected
            isSelected = true;
        }
    }
}
function destroy(){
    FlxG.camera.bgColor = 0xff000000;
}