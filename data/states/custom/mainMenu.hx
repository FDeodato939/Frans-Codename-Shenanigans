// library
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
// variable
var itemList:Array<String> = ['freeplay', 'options'];
var editorPicker:Bool = false;
var modSwitchMenu:Bool = false;
var isSelected:Bool = false;
var curSelected:Int = 0;
// functions
function create(){
	// playMenuSong
    CoolUtil.playMenuSong();
    // checkerboard
    add(checkerboard = new FlxBackdrop(FlxGridOverlay.createGrid(32, 32, FlxG.width, FlxG.height, true, 0xff1a1a1a, 0xff333333)));
    checkerboard.velocity.x = -50;
    // tilemap
    add(tilemap = new FlxBackdrop(Paths.image('menus/tilemap')));
    tilemap.scale.set(3, 3);
    tilemap.velocity.x = -70;
    tilemap.screenCenter();
    // itemGroup
    itemGroup = new FlxSpriteGroup();
    for(i in 0...itemList.length){
        item = new FlxSprite();
        item.frames = Paths.getFrames('menus/mainMenu/'+itemList[i]);
        item.animation.addByPrefix('idle', itemList[i]+' basic');
        item.animation.addByPrefix('selected', itemList[i]+' white');
        item.animation.play('idle');
        item.scale.set(0.8, 0.8);
        item.antialiasing = true;
        item.screenCenter();
        itemGroup.add(item);
        item.ID = i;
    }
    add(itemGroup);
    // freeplay
    itemGroup.members[0].y = 250;
    // options
    itemGroup.members[1].y = 370;
}
function update(elapsed){
    // modSwitchMenu
    if(controls.SWITCHMOD){
        if(!modSwitchMenu){
            openSubState(new ModSwitchMenu());
            modSwitchMenu = true;
        }else{
            closeSubState(new ModSwitchMenu());
            modSwitchMenu = false;
        }
    }
    // editorPicker
    if(FlxG.keys.justPressed.SEVEN){
        if(!editorPicker){
            openSubState(new EditorPicker());
            editorPicker = true;
        }else{
            closeSubState(new EditorPicker());
            editorPicker = false;
        }
    }
    // debugMenus
    if(!editorPicker && !modSwitchMenu){
        if(!isSelected){
            // controls
            if(controls.ACCEPT){
                // sound
                FlxG.sound.play(Paths.sound('menu/confirm'));
                // camera
                FlxTween.tween(FlxG.camera, {alpha: 0}, 0.8, {ease: FlxEase.smootherStepInOut});
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
                // camera
                FlxTween.tween(FlxG.camera, {alpha: 0}, 0.2, {ease: FlxEase.smootherStepInOut});
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
            // keys
            if(FlxG.keys.justPressed.H){
                // state
                FlxG.switchState(new ModState('custom/hl1'));
                // isSelected
                isSelected = true;
            }
            if(FlxG.keys.justPressed.M){
                // state
                FlxG.switchState(new ModState('custom/smb'));
                // isSelected
                isSelected = true;
            }
            if(FlxG.keys.justPressed.S){
                // state
                FlxG.switchState(new ModState('custom/sonic'));
                // isSelected
                isSelected = true;
            }
        }
    }
    // curSelected
    if(curSelected < 0){
        curSelected = itemList.length - 1;
    }else if(curSelected > (itemList.length - 1)){
        curSelected = 0;
    }
    // itemGroup
    itemGroup.forEach(function(item:FlxSprite){
        if(item.ID == curSelected){
            FlxTween.tween(item.scale, {x: 0.8, y: 0.8}, 0.1, {ease: FlxEase.smootherStepInOut});
            FlxTween.tween(item, {alpha: 1}, 0.1);
        }else{
            FlxTween.tween(item.scale, {x: 0.7, y: 0.7}, 0.1, {ease: FlxEase.smootherStepInOut});
            FlxTween.tween(item, {alpha: 0.5}, 0.1);
        }
    });
}