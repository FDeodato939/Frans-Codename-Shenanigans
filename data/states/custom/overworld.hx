// variables
static var overworldList:Array;
static var overworldCam:FlxCamera;
var isSelected:Bool = false;
// functions
function create(){
    // overworldList
    overworldList = Json.parse(Assets.getText(Paths.json('../data/jsons/overworld')));
    // camera
    FlxG.camera.zoom = 3;
    FlxG.camera.bgColor = 0xff64b0ff;
    // importScript
    importScript('data/scripts/overworld/tilemap');
    importScript('data/scripts/overworld/doors');
    importScript('data/scripts/overworld/mario');
    importScript('data/scripts/overworld/freeplay');
    // worldBounds
    FlxG.worldBounds.set(-100000, -100000, 200000, 200000);
    // overworldCam
    overworldCam = new FlxCamera();
    overworldCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(overworldCam, false);
}
function update(elapsed){
    // camera
    FlxG.camera.follow(marioHB);
    // isSelected
    if(!isSelected){
        // controls
        if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // state
            new FlxTimer().start(0.25, function(){FlxG.switchState(new MainMenuState());});
            // isSelected
            isSelected = true;
        }
        // keys
        if(FlxG.keys.justPressed.M){
            // sound
            FlxG.sound.play(Paths.sound('menu/confirm'));
            // state
            new FlxTimer().start(0.85, function(){FlxG.switchState(new ModState('custom/minigames/sonic'));});
            // isSelected
            isSelected = true;
        }
    }
}
function destroy(){
    FlxG.camera.bgColor = 0xff000000;
}