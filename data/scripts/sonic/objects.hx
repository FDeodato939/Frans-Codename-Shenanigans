// library
import flixel.util.FlxDirectionFlags;
// variable
static var objectList:Array;
// functions
function create(){
    // objectList
    objectList = Json.parse(Assets.getText(Paths.json('../data/tutorialZone')));
    // rfSpringGroup
    add(rfSpringGroup = new FlxSpriteGroup());
    for(i in 0...objectList.redSprings.floor.length){
        // floor
        rfSpringGroup.add(rfSpring = new FlxSprite(objectList.redSprings.floor[i].positions[0], objectList.redSprings.floor[i].positions[1]).loadGraphic(Paths.image('chaotix/objects/floorRedSpring')));
        rfSpring.flipY = objectList.redSprings.floor[i].flip;
        rfSpring.immovable = true;
        rfSpring.ID = i;
    }
    // rwSpringGroup
    add(rwSpringGroup = new FlxSpriteGroup());
    for(i in 0...objectList.redSprings.wall.length){
        rwSpringGroup.add(rwSpring = new FlxSprite(objectList.redSprings.wall[i].positions[0], objectList.redSprings.wall[i].positions[1]).loadGraphic(Paths.image('chaotix/objects/wallRedSpring')));
        rwSpring.flipX = objectList.redSprings.wall[i].flip;
        rwSpring.immovable = true;
        rwSpring.ID = i;
    }
}
function update(elapsed){
    // rfSpringGroup
    rfSpringGroup.forEach(function(rfSpring){
        // collide
        FlxG.collide([knucklesHB, blueKnucklesHB], rfSpring, function(characterGroup){
            if(rfSpring.flipY){
                // sound
                FlxG.sound.play(Paths.sound('chaotix/spring'));
                // velocity
                characterGroup.velocity.y = characterGroup.maxVelocity.y / 1;
                // rfSpring
                rfSpring.y -= 10;
            }else{
                // sound
                FlxG.sound.play(Paths.sound('chaotix/spring'));
                // velocity
                characterGroup.velocity.y = -characterGroup.maxVelocity.y / 1;
                // rfSpring
                rfSpring.y += 10;
            }
        });
        // rfSpring
        if(rfSpring.flipY){
            rfSpring.y = lerp(rfSpring.y, objectList.redSprings.floor[rfSpring.ID].positions[1], 0.3);
        }else{
            rfSpring.y = lerp(rfSpring.y, objectList.redSprings.floor[rfSpring.ID].positions[1], 0.3);
        }
    });
    // rwSpringGroup
    rwSpringGroup.forEach(function(rwSpring){
        // collide
        FlxG.collide([knucklesHB, blueKnucklesHB], rwSpring, function(characterGroup){
            if(rwSpring.flipX){
                // sound
                FlxG.sound.play(Paths.sound('chaotix/spring'));
                // velocity
                characterGroup.velocity.x = -characterGroup.maxVelocity.x;
                // rwSpring
                rwSpring.x += 10;
            }else{
                // sound
                FlxG.sound.play(Paths.sound('chaotix/spring'));
                // velocity
                characterGroup.velocity.x = characterGroup.maxVelocity.x;
                // rwSpring
                rwSpring.x -= 10;
            }
        });
        // rwSpring
        if(rwSpring.flipX){
            rwSpring.x = lerp(rwSpring.x, objectList.redSprings.wall[rwSpring.ID].positions[0], 0.3);
        }else{
            rwSpring.x = lerp(rwSpring.x, objectList.redSprings.wall[rwSpring.ID].positions[0], 0.3);
        }
    });
}