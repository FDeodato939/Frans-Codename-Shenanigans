// libraries
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
// variables
static var isFreeplayOpen:Bool = false;
var curSelected:Int = 0;
// functions
function create(){
	// playMenuSong
    CoolUtil.playMenuSong();
    // isFreeplayOpen
    isFreeplayOpen = false;
    // notes
    add(notes = new FlxBackdrop(Paths.image('menus/notes')));
    notes.antialiasing = true;
    notes.velocity.set(50, 50);
    notes.cameras = [overworldHUD];
    // cinematicGroup
    add(cinematicGroup = new FlxGroup());
    for(i in 0...2){
        cinematicGroup.add(bar = new FlxSprite().makeGraphic(FlxG.width, 150, FlxColor.BLACK));
    }
    cinematicGroup.members[0].y = -150;
    cinematicGroup.members[1].y = 720;
    cinematicGroup.cameras = [overworldHUD];
    // songName
    add(songName = new FlxText(0, 0, FlxG.width, '< NULL >', 42));
    songName.alignment = 'center';
    songName.cameras = [overworldHUD];
    // songCredits
    add(songCredits = new FlxText(0, 0, FlxG.width, 'Composers: NULL | Artists: NULL | Charters: NULL', 24));
    songCredits.alignment = 'center';
    songCredits.cameras = [overworldHUD];
}
function update(elapsed){
    // doorGroup
    doorGroup.forEach(function(door){
        if(FlxG.overlap(marioHB, door)){
            // controls
            if(controls.UP_P){
                if(isFreeplayOpen){
                    isFreeplayOpen = false;
                }else{
                    isFreeplayOpen = true;
                }
            }
            // curSelected
            if(curSelected < 0){
                curSelected = overworldList.doors[door.ID].songs.length - 1;
            }else if(curSelected > (overworldList.doors[door.ID].songs.length - 1)){
                curSelected = 0;
            }
            // songName
            songName.text = '< '+overworldList.doors[door.ID].songs[curSelected].name.toUpperCase()+' >';
            // songCredits
            songCredits.text = 'Composers: '+overworldList.doors[door.ID].songs[curSelected].credits.composers+' | Artists: '+overworldList.doors[door.ID].songs[curSelected].credits.artits+' | Charters: '+overworldList.doors[door.ID].songs[curSelected].credits.charters;
        }
    });
    // isFreeplayOpen
    if(isFreeplayOpen){
        // doorGroup
        if(!FlxG.overlap(marioHB, doorGroup)){
            isFreeplayOpen = false;
        }
        // controls
        if(controls.ACCEPT){
            // sound
            FlxG.sound.play(Paths.sound('menu/confirm'));
            // doorGroup
            doorGroup.forEach(function(door){
                if(FlxG.overlap(marioHB, door)){
                    PlayState.loadSong(overworldList.doors[door.ID].songs[curSelected].name, 'hard');
                }
            });
            // switchState
            new FlxTimer().start(0.85, function(){FlxG.switchState(new PlayState());});
        }
        if(controls.LEFT_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // curSelected
            curSelected -= 1;
        }else if(controls.RIGHT_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // curSelected
            curSelected += 1;
        }
        // notes
        notes.alpha = lerp(notes.alpha, 0.5, 0.3);
        // cinematicGroup
        cinematicGroup.members[0].y = lerp(cinematicGroup.members[0].y, 0, 0.3);
        cinematicGroup.members[1].y = lerp(cinematicGroup.members[1].y, 570, 0.3);
    }else{
        // notes
        notes.alpha = lerp(notes.alpha, 0, 0.3);
        // cinematicGroup
        cinematicGroup.members[0].y = lerp(cinematicGroup.members[0].y, -150, 0.3);
        cinematicGroup.members[1].y = lerp(cinematicGroup.members[1].y, 720, 0.3);
    }
    // songName
    songName.y = cinematicGroup.members[0].y + 48;
    // songCredits
    songCredits.y = cinematicGroup.members[1].y + 56;
}