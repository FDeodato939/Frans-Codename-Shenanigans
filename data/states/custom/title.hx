// libraries
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
// variable
var isSelected:Bool = false;
// functions
function create(){
	// playMenuSong
    CoolUtil.playMenuSong();
    // checkerboard
    add(checkerboard = new FlxBackdrop(FlxGridOverlay.createGrid(32, 32, FlxG.width, FlxG.height, true, 0xff1a1a1a, 0xff333333)));
    checkerboard.velocity.x = -50;
    // logo
    logo = new FlxSprite(310, 125).loadGraphic(Paths.image('menus/logo'));
    logo.scale.set(1, 1);
    logo.antialiasing = true;
    add(logo);
    // blackBar
    add(blackBar = new FlxSprite(0, 570).makeGraphic(FlxG.width, 150, 0xff000000));
    // enter
    add(enter = new FlxText(0, 625, FlxG.width, 'Press ENTER to begin', 32));
    enter.alignment = 'center';
    FlxTween.tween(enter, {alpha: 0}, 1, {type: FlxTween.PINGPONG});
}
function update(elapsed){
    // isSelected
    if(!isSelected){
        if(controls.ACCEPT){
            // sound
            FlxG.sound.play(Paths.sound('menu/confirm'));
            // isSelected
            isSelected = true;
            // enter
            FlxFlicker.flicker(enter, 0.85, 0.08, false, false, function(flick:FlxFlicker){
                FlxG.switchState(new MainMenuState());
            });
        }
    }
    // logo
    logo.scale.set(lerp(logo.scale.x, 1, 0.1), lerp(logo.scale.y, 1, 0.1));
}
function beatHit(curBeat){
    logo.scale.set(1.1, 1.1);
}