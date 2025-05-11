// libraries
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
import flixel.effects.FlxFlicker;
// variables
var itemList:Array<String> = ['overworld', 'options'];
var isSelected:Bool = false;
var curSelected:Int = 0;
// functions
function create(){
	// playMenuSong
    CoolUtil.playMenuSong();
    // notes
    add(notes = new FlxBackdrop(Paths.image('menus/notes')));
    notes.antialiasing = true;
    notes.velocity.set(50, 50);
    // itemGroup
    add(itemGroup = new FlxGroup());
    for(items in 0...itemList.length){
        itemGroup.add(item = new FlxText(0, 0, FlxG.width, itemList[items].toUpperCase(), 42));
        item.alignment = 'center';
        item.borderStyle = FlxTextBorderStyle.OUTLINE;
        item.borderSize = 3;
        item.ID = items;
    }
    itemGroup.members[0].y = 290;
    itemGroup.members[1].y = 390;
    // cinematicGroup
    add(cinematicGroup = new FlxGroup());
    for(i in 0...2){
        cinematicGroup.add(bar = new FlxSprite().makeGraphic(FlxG.width, 150, FlxColor.BLACK));
    }
    cinematicGroup.members[0].y = 0;
    cinematicGroup.members[1].y = 570;
}
function update(elapsed){
    // ModSwitchMenu
    if(controls.SWITCHMOD){
        // openSubState
        openSubState(new ModSwitchMenu());
        // persistent
        persistentUpdate = false;
        persistentDraw = true;
    }
    // EditorPicker
    if(FlxG.keys.justPressed.SEVEN){
        // openSubState
        openSubState(new EditorPicker());
        // persistent
        persistentUpdate = false;
        persistentDraw = true;
    }
    // isSelected
    if(!isSelected){
        if(controls.ACCEPT){
            // sound
            FlxG.sound.play(Paths.sound('menu/confirm'));
            // isSelected
            isSelected = true;
            // curSelected
            if(curSelected == 0){
                new FlxTimer().start(0.85, function(){FlxG.switchState(new FreeplayState());});
            }else if(curSelected == 1){
                new FlxTimer().start(0.85, function(){FlxG.switchState(new OptionsMenu());});
            }
            // itemGroup
            itemGroup.forEach(function(item:FlxSprite){
                if(item.ID == curSelected){
                    FlxFlicker.flicker(item, 0.85, 0.08, false, false);
                }
            });
        }else if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // state
            new FlxTimer().start(0.25, function(){FlxG.switchState(new TitleState());});
            // isSelected
            isSelected = true;
        }
        if(controls.UP_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // curSelected
            curSelected -= 1;
        }else if(controls.DOWN_P){
            // sound
            FlxG.sound.play(Paths.sound('menu/scroll'));
            // curSelected
            curSelected += 1;
        }
    }
    // curSelected
    if(curSelected < 0){
        curSelected = itemList.length - 1;
    }else if(curSelected > (itemList.length - 1)){
        curSelected = 0;
    }
    // itemGroup
    itemGroup.forEach(function(item){
        if(item.ID == curSelected){
            item.alpha = lerp(item.alpha, 1, 0.3);
        }else{
            item.alpha = lerp(item.alpha, 0.5, 0.3);
        }
    });
}