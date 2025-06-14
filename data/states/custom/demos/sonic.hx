// variables
static var sonicList:Array;
static var sonicCam:FlxCamera;
var isSelected:Bool = false;
// functions
function create(){
    // sonicList
    sonicList = Json.parse(Assets.getText(Paths.json('../data/jsons/sonic')));
    // camera
    FlxG.camera.zoom = 3;
    FlxG.camera.bgColor = 0xff000000;
    // importScript
    importScript('data/scripts/demos/sonic/backdrop');
    importScript('data/scripts/demos/sonic/camFollow');
    importScript('data/scripts/demos/sonic/sonic');
    importScript('data/scripts/demos/sonic/badniks/motobug');
    importScript('data/scripts/demos/sonic/badniks/chopper');
    importScript('data/scripts/demos/sonic/tilemap');
    importScript('data/scripts/demos/sonic/hud');
    // worldBounds
    FlxG.worldBounds.set(-100000, -100000, 200000, 200000);
    // sonicCam
    sonicCam = new FlxCamera();
    sonicCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(sonicCam, false);
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