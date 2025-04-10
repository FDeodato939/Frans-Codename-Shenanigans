// library
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
import flixel.effects.FlxFlicker;
// variable
var isSelected:Bool = false;
var isSongPlaying:Bool = true;
var curSelected:Int = 0;
var instVoid:Void = function(){FlxG.sound.playMusic(Paths.inst(songs[curSelected], 'hard'));};
// functions
function create(){
    // title
    window.title = "Vs. Blue Horse (CNE Template)";
    // songs
    songs = CoolUtil.coolTextFile(Paths.txt('songs'));
    // camFollow
	camFollow = new FlxSprite(475, 35);
	camFollow.makeGraphic();
    add(camFollow);
    // bg
    bg = new FlxBackdrop(Paths.image('menus/backdropHorse'));
    bg.antialiasing = true;
    bg.velocity.set(50, 50);
    add(bg);
    // songGroup
    songGroup = new FlxSpriteGroup();
    for(i in 0...songs.length){
        songName = new FlxText(0, i * 60, FlxG.width, songs[i], 42);
        songName.font = Paths.font('vcr.ttf');
        songName.alignment = 'center';
        songName.borderStyle = FlxTextBorderStyle.OUTLINE;
        songName.borderSize = 3;
        songGroup.add(songName);
        songName.ID = i;
    }
    add(songGroup);
}
function update(elapsed){
    if(!isSelected){
        if(controls.ACCEPT){
            // sound
            FlxG.sound.play(Paths.sound('menu/confirm'));
            // camera
            FlxTween.tween(FlxG.camera, {alpha: 0}, 0.8, {ease: FlxEase.smootherStepInOut});
            // loadSong
            PlayState.loadSong(songs[curSelected], 'hard');
            // isSelected
            isSelected = true;
            // state
            new FlxTimer().start(0.85, function(){FlxG.switchState(new PlayState());});
            // songGroup
            songGroup.forEach(function(song:FlxSprite){
                if(song.ID == curSelected){
                    FlxFlicker.flicker(song, 0.85, 0.08, false, false);
                }
            });
        }else if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // camera
            FlxTween.tween(FlxG.camera, {alpha: 0}, 0.2, {ease: FlxEase.smootherStepInOut});
            // state
            new FlxTimer().start(0.25, function(){FlxG.switchState(new MainMenuState());});
            // isSelected
            isSelected = true;
        }
        if(controls.UP_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // isSongPlaying
            isSongPlaying = true;
            // curSelected
            curSelected -= 1;
            // camFollow
            camFollow.y -= 60;
        }else if(controls.DOWN_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // isSongPlaying
            isSongPlaying = true;
            // curSelected
            curSelected += 1;
            // camFollow
            camFollow.y += 60;
        }
    }
    // isSongPlaying
    if(isSongPlaying){
        // execAsync
        Main.execAsync(instVoid);
        // isSongPlaying
        isSongPlaying = false;
    }
    // curSelected
    if(curSelected < 0){
        curSelected = songs.length - 1;
        // camFollow
        camFollow.y = 60 * songs.length;
    }else if(curSelected > (songs.length - 1)){
        // curSelected
        curSelected = 0;
        // camFollow
        camFollow.y = 35;
    }
    // camFollow
    FlxG.camera.follow(camFollow);
    // songGroup
    songGroup.forEach(function(songName:FlxText){
        if(songName.ID == curSelected){
            FlxTween.tween(songName, {size: 42, alpha: 1}, 0.1, {ease: FlxEase.smootherStepInOut});
        }else{
            FlxTween.tween(songName, {size: 28, alpha: 0.5}, 0.1, {ease: FlxEase.smootherStepInOut});
        }
    });
}