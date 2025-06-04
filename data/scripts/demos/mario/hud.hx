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
    blackBarGroup.cameras = [marioCam];
    // marioInfo
    add(marioInfo = new FlxText(0, 0, FlxG.width, 'NULL', 12));
    marioInfo.alignment = 'right';
    marioInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    marioInfo.borderSize = 3;
    marioInfo.cameras = [marioCam];
}
function update(elapsed){
    marioInfo.text = 'X: '+Std.int(marioHB.x)+'\nY: '+Std.int(marioHB.y)+'\nVelocity: '+Std.int(marioHB.velocity.x)+'\nGravity: '+Std.int(marioHB.velocity.y);
}