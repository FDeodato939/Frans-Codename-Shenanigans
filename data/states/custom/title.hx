// library
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
// variable
var isSelected:Bool = false;
// functions
function create(){
	// playMenuSong
    CoolUtil.playMenuSong();
    // notes
    add(notes = new FlxBackdrop(Paths.image('menus/notes')));
    notes.antialiasing = true;
    notes.velocity.set(50, 50);
    // logo
    add(logo = new FlxSprite(310, 125).loadGraphic(Paths.image('menus/logo')));
    logo.scale.set(1, 1);
    logo.antialiasing = true;
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
            // enter
            FlxFlicker.flicker(enter, 0.85, 0.08, false, false, function(flick){
                FlxG.switchState(new MainMenuState());
            });
            // isSelected
            isSelected = true;
        }
    }
    // logo
    logo.scale.set(lerp(logo.scale.x, 1, 0.1), lerp(logo.scale.y, 1, 0.1));
}
function beatHit(curBeat){
    logo.scale.set(1.1, 1.1);
}