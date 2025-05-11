// library
import funkin.backend.utils.WindowUtils;
// variable
static var customStates:Map<FlxState, String> = [
    TitleState => 'custom/title',
    MainMenuState => 'custom/mainMenu',
    FreeplayState => 'custom/overworld',
];
// functions
function preStateSwitch(){
    // resetTitle
    WindowUtils.resetTitle();
    // title
    window.title = "Frans Codename Shenanigans";
    // camera
    FlxG.camera.bgColor = 0xff000000;
    // redirectStates
    for(redirectStates in customStates.keys()){
        if(FlxG.game._requestedState is redirectStates){
            FlxG.game._requestedState = new ModState(customStates.get(redirectStates));
        }
    }
}
function destroy(){
    window.title = "Friday Night Funkin' - Codename Engine";
}