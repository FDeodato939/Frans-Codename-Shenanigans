// variables
static var doorGroup:FlxSpriteGroup;
// functions
function create(){
    add(doorGroup = new FlxSpriteGroup());
    for(i in 0...overworldList.doors.length){
        doorGroup.add(door = new FlxSprite(overworldList.doors[i].position[0], overworldList.doors[i].position[1]).loadGraphic(Paths.image('overworld/door')));
        door.ID = i;
    }
}