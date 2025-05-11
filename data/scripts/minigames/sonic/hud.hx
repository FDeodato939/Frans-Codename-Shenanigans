// library
import flixel.text.FlxTextBorderStyle;
// functions
function create(){
    // blackBarGroup
    add(blackBarGroup = new FlxGroup());
    for(blackBars in 0...2){
        blackBarGroup.add(blackBar = new FlxSprite().makeGraphic(240, FlxG.height, FlxColor.BLACK));
    }
    blackBarGroup.members[0].x = 0;
    blackBarGroup.members[1].x = 1040;
    blackBarGroup.cameras = [sonicCam];
    // sonicInfo
    add(sonicInfo = new FlxText(0, 0, FlxG.width, 'NULL', 12));
    sonicInfo.alignment = 'right';
    sonicInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    sonicInfo.borderSize = 3;
    sonicInfo.cameras = [sonicCam];
}
function update(elapsed){
    sonicInfo.text = 'X: '+Std.int(sonicHB.x)+'\nY: '+Std.int(sonicHB.y)+'\nVelocity: '+Std.int(sonicHB.velocity.x)+'\nGravity: '+Std.int(sonicHB.velocity.y)+'\nisRolling: '+isRolling+'\nisSpindashing: '+isSpindashing+'\nspinVelocity: '+spinVelocity;
}