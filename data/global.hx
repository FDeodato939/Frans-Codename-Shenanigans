// libraries
import lime.graphics.Image;
import funkin.backend.utils.WindowUtils;
// variable
static var redirectStates:Map<FlxState, String> = [
    TitleState => 'custom/title',
    MainMenuState => 'custom/mainMenu',
    FreeplayState => 'custom/freeplay',
];
function preStateSwitch(){
    // resetTitle
    WindowUtils.resetTitle();
    // window
    window.title = "Frans Codename Shenanigans";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('game/icon'))));
    // camera
    FlxG.camera.bgColor = 0xff000000;
    // redirectStates
    for(redirectState in redirectStates.keys()){
        if(FlxG.game._requestedState is redirectState){
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
        }
    }
}
function destroy(){
    window.title = "Friday Night Funkin' - Codename Engine";
}