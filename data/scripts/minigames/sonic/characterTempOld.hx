// library
import flixel.util.FlxDirectionFlags;
import flixel.text.FlxTextBorderStyle;
// variable
static var knucklesHB:FlxSprite;
var isRolling:Bool = false;
var isSpindashing:Bool = false;
var spinVelocity:Int = 0;
// function
function create(){
    // knucklesHB
    add(knucklesHB = new FlxSprite(320, 580).makeGraphic(22, 28, 0xffd01050));
    knucklesHB.updateHitbox();
    knucklesHB.maxVelocity.set(300, 760);
    knucklesHB.acceleration.y = 750;
    knucklesHB.drag.x = knucklesHB.maxVelocity.x;
    // knucklesSprite
    add(knucklesSprite = new FlxSprite());
	knucklesSprite.frames = Paths.getFrames('chaotix/characters/knuckles');
	knucklesSprite.animation.addByPrefix('idle', 'idle');
	knucklesSprite.animation.addByPrefix('up', 'up');
	knucklesSprite.animation.addByPrefix('down', 'down', 12, false);
	knucklesSprite.animation.addByPrefix('holding', 'holding', 12);
	knucklesSprite.animation.addByPrefix('spindash', 'spindash', 16);
	knucklesSprite.animation.addByPrefix('walking', 'walking', 12);
	knucklesSprite.animation.addByPrefix('running', 'running', 16);
	knucklesSprite.animation.addByPrefix('rolling', 'rolling', 16);
	knucklesSprite.animation.play('idle');
    knucklesSprite.origin.set(0, 0);
    // knucklesInfo
    add(knucklesInfo = new FlxText(0, 0, FlxG.width, 'NULL', 12));
    knucklesInfo.alignment = 'right';
    knucklesInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    knucklesInfo.borderSize = 3;
    knucklesInfo.cameras = [chaotixCam];
}
function update(elapsed){
    // knucklesInfo
    knucklesInfo.text = 'X: '+Std.int(knucklesHB.x)+'\nY: '+Std.int(knucklesHB.y)+'\nVelocity: '+Std.int(knucklesHB.velocity.x)+'\nGravity: '+Std.int(knucklesHB.velocity.y)+'\nisRolling: '+isRolling+'\nisSpindashing: '+isSpindashing+'\nspinVelocity: '+spinVelocity;
    // moving
    if(!isRolling && !isSpindashing){
        // maxVelocity
        knucklesHB.maxVelocity.x = 300;
        // moving
        if(controls.LEFT){
            knucklesSprite.flipX = true;
            knucklesHB.velocity.x -= 5;
        }
        if(controls.RIGHT){
            knucklesSprite.flipX = false;
            knucklesHB.velocity.x += 5;
        }
    }
    // ground
    if((knucklesHB.velocity.y >= 0) && knucklesHB.isTouching(FlxDirectionFlags.FLOOR)){
        if(knucklesHB.velocity.x < 0 || knucklesHB.velocity.x > 0){
            if(controls.DOWN_P){
                isRolling = true;
            }
        }else{
            if(controls.DOWN){
                if(FlxG.keys.justPressed.X){
                    isSpindashing = true;
                }
            }
        }
    }
    // rolling
    if(knucklesHB.velocity.x == 0){
        isRolling = false;
    }
    // isSpindashing
    if(isSpindashing){
        // controls
        if(controls.DOWN){
            if(FlxG.keys.justPressed.X){
                if(spinVelocity < knucklesHB.maxVelocity.x){
                    spinVelocity += 100;
                }
            }
        }else{
            // isRolling
            isRolling = true;
            // isSpindashing
            isSpindashing = false;
            // flipped
            if(knucklesSprite.flipX){
                knucklesHB.velocity.x -= spinVelocity;
            }else{
                knucklesHB.velocity.x += spinVelocity;
            }
            // spinVelocity
            spinVelocity = 0;
        }
        // maxVelocity
        knucklesHB.maxVelocity.x = 400;
    }else{
        if((knucklesHB.velocity.y >= 0) && knucklesHB.isTouching(FlxDirectionFlags.FLOOR)){
            if(FlxG.keys.justPressed.X){
                // isRolling
                isRolling = false;
                // velocity
                knucklesHB.velocity.y = -knucklesHB.maxVelocity.y / 2;
                // animation
                knucklesSprite.animation.play('rolling');
            }
        }
    }
    // flipped
    if(knucklesSprite.flipX){
        knucklesSprite.setPosition(knucklesHB.x - 12, knucklesHB.y - 22);
    }else{
        knucklesSprite.setPosition(knucklesHB.x - 16, knucklesHB.y - 22);
    }
    // animation
    if((knucklesHB.velocity.y >= 0) && knucklesHB.isTouching(FlxDirectionFlags.FLOOR)){
        if((knucklesHB.velocity.x < 0 || knucklesHB.velocity.x > 0) && !knucklesHB.isTouching(FlxDirectionFlags.WALL)){
            if(isRolling){
                knucklesSprite.animation.play('rolling');
            }else{
                if((knucklesHB.velocity.x <= -300) || (knucklesHB.velocity.x >= 300)){
                    knucklesSprite.animation.play('running');
                }else{
                    knucklesSprite.animation.play('walking');
                }
            }
        }else{
            if(isSpindashing){
                knucklesSprite.animation.play('spindash');
            }else{
                if(!knucklesSprite.animation.finished){
                    if(controls.UP){
                        knucklesSprite.animation.play('up');
                    }else if(controls.DOWN){
                        knucklesSprite.animation.play('down');
                    }else{
                        knucklesSprite.animation.play('idle');
                    }
                }
            }
        }
    }
}