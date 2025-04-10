// library
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
// functions
function create(event){
    // cancel
	event.cancel();
	// pauseCam
    pauseCam = new FlxCamera();
    pauseCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(pauseCam, false);
    // bg
    bg = new FlxBackdrop(Paths.image('menus/backdropHorse'));
    bg.velocity.set(50, 50);
	bg.alpha = 0.8;
    add(bg);
    // itemGroup
    itemGroup = new FlxSpriteGroup();
    for(i in 0...menuItems.length){
        item = new FlxText(0, (FlxG.height / 3) + (i * 50), FlxG.width, menuItems[i], 42);
        item.font = Paths.font('vcr.ttf');
        item.alignment = 'center';
        item.borderStyle = FlxTextBorderStyle.OUTLINE;
        item.borderSize = 3;
        itemGroup.add(item);
        item.ID = i;
    }
    add(itemGroup);
	// cameras
    cameras = [pauseCam];
}
function update(elapsed){
	// controls
	if(controls.ACCEPT){
		selectOption();
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
	// curSelected
	if(curSelected < 0){
        curSelected = menuItems.length - 1;
	}else if(curSelected > (menuItems.length - 1)){
        curSelected = 0;
	}
    // itemGroup
    itemGroup.forEach(function(item:FlxText){
        if(item.ID == curSelected){
            item.color = FlxColor.BLUE;
        }else{
            item.color = FlxColor.WHITE;
        }
    });
}