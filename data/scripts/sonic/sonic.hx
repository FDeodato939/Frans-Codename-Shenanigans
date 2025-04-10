// library
import flixel.util.FlxDirectionFlags;
// variable
static var sonicHB:FlxSprite;
var sdVelocity:Int = 0;
var isRolling:Bool = false;
var isSpindashing:Bool = false;
// function
function create(){
    // sonicHB
    add(sonicHB = new FlxSprite(358, 580).makeGraphic(16, 30, 0xff6c6cfc));
    sonicHB.updateHitbox();
    sonicHB.maxVelocity.set(300, 600);
    sonicHB.acceleration.y = 450;
    sonicHB.drag.x = sonicHB.maxVelocity.x;
    sonicHB.drag.y = sonicHB.maxVelocity.y;
    // sonicSprite
    add(sonicSprite = new FlxSprite());
	sonicSprite.frames = Paths.getFrames('sonic/characters/sonic');
	sonicSprite.animation.addByPrefix('idle', 'idle');
	sonicSprite.animation.addByPrefix('hurt', 'hurt', 16, false);
	sonicSprite.animation.addByPrefix('death', 'death');
	sonicSprite.animation.addByPrefix('up', 'up', 16, false);
	sonicSprite.animation.addByPrefix('down', 'down', 16, false);
	sonicSprite.animation.addByPrefix('spindash', 'spindash', 16);
	sonicSprite.animation.addByPrefix('walking', 'walking', 12);
	sonicSprite.animation.addByPrefix('running', 'running', 16);
	sonicSprite.animation.addByPrefix('rolling', 'rolling', 16);
	sonicSprite.animation.addByPrefix('peelOut', 'peelOut', 16);
	sonicSprite.animation.play('idle');
    sonicSprite.origin.set(0, 0);
}
function update(elapsed){
    // characterInfo
    characterInfo.text = 'X: '+Std.int(sonicHB.x)+'\nY: '+Std.int(sonicHB.y)+'\nVelocity: '+Std.int(sonicHB.velocity.x)+'\nGravity: '+Std.int(sonicHB.velocity.y)+'\nDash: '+sdVelocity+'\nisRolling: '+isRolling+'\nisSpindashing: '+isSpindashing;
    // not isRolling/isSpindashing
    if(!isRolling && !isSpindashing){
        // maxVelocity
        sonicHB.maxVelocity.x = 300;
        // isTouching
        if(sonicHB.isTouching(FlxDirectionFlags.FLOOR) && sonicHB.velocity.y >= 0){
            // moving
            if(!controls.UP && !controls.DOWN){
                if(controls.LEFT){
                    // flipX
                    sonicSprite.flipX = true;
                    // velocity
                    sonicHB.velocity.x -= 5;
                }
                if(controls.RIGHT){
                    // flipX
                    sonicSprite.flipX = false;
                    // velocity
                    sonicHB.velocity.x += 5;
                }
            }
            // rolling
            if(!sonicHB.isTouching(FlxDirectionFlags.WALL) && (sonicHB.velocity.x < 0 || sonicHB.velocity.x > 0)){
                if(controls.DOWN_P){
                    // sound
                    FlxG.sound.play(Paths.sound('sonic/charge'));
                    // isRolling
                    isRolling = true;
                }
            }
            // spindash
            if(sonicHB.isTouching(FlxDirectionFlags.FLOOR) && (sonicSprite.animation.name == 'down' && sonicHB.velocity.y >= 0)){
                if(controls.DOWN && FlxG.keys.justPressed.X){
                    isSpindashing = true;
                }
            }
        }else{
            if(controls.LEFT){
                // flipX
                sonicSprite.flipX = true;
                // velocity
                sonicHB.velocity.x -= 5;
            }
            if(controls.RIGHT){
                // flipX
                sonicSprite.flipX = false;
                // velocity
                sonicHB.velocity.x += 5;
            }
        }
    }
    // jumping
    if(sonicHB.isTouching(FlxDirectionFlags.FLOOR) && sonicHB.velocity.y >= 0){
        if(!isSpindashing && FlxG.keys.justPressed.X){
            // sound
            FlxG.sound.play(Paths.sound('sonic/jump'));
            // isRolling
            isRolling = false;
            // velocity
            sonicHB.velocity.y = -sonicHB.maxVelocity.y / 2;
        }
    }
    // rolling
    if(isRolling){
        if(sonicHB.velocity.x == 0){
            isRolling = false;
        }
    }
    // spindash
    if(isSpindashing){
        // maxVelocity
        sonicHB.maxVelocity.x = 500;
        // isSpindashing
        if(controls.DOWN){
            if(FlxG.keys.justPressed.X){
                // sound
                FlxG.sound.play(Paths.sound('sonic/charge'));
                // sdVelocity
                if(sdVelocity < sonicHB.maxVelocity.x){
                    sdVelocity += 100;
                }
                // sonicSprite
                sonicSprite.animation.play('spindash');
            }
        }else{
            // isSpindashing
            isSpindashing = false;
            // isRolling
            isRolling = true;
            // velocity
            if(sonicSprite.flipX){
                sonicHB.velocity.x = -sonicHB.maxVelocity.x;
            }else{
                sonicHB.velocity.x = sonicHB.maxVelocity.x;
            }
            // sdVelocity
            sdVelocity = 0;
        }
    }
    // sonicSprite
    if(sonicSprite.flipX){
        sonicSprite.setPosition(sonicHB.x - 16, sonicHB.y - 20);
    }else{
        sonicSprite.setPosition(sonicHB.x - 18, sonicHB.y - 20);
    }
    // animations
    if(sonicHB.isTouching(FlxDirectionFlags.FLOOR) && sonicHB.velocity.y >= 0){
        if(!sonicHB.isTouching(FlxDirectionFlags.WALL) && (sonicHB.velocity.x < 0 || sonicHB.velocity.x > 0)){
            if(isRolling){
                sonicSprite.animation.play('rolling');
            }else{
                if(sonicHB.velocity.x < 300 && sonicHB.velocity.x > -300){
                    sonicSprite.animation.play('walking');
                }else{
                    sonicSprite.animation.play('running');
                }
            }
        }else{
            if(!isSpindashing && !sonicSprite.animation.finished){
                if(controls.UP){
                    sonicSprite.animation.play('up');
                }else if(controls.DOWN){
                    sonicSprite.animation.play('down');
                }else{
                    sonicSprite.animation.play('idle');
                }
            }else{
                if(!controls.UP && !controls.DOWN){
                    sonicSprite.animation.play('idle');
                }
            }
        }
    }else if(sonicHB.isTouching(FlxDirectionFlags.FLOOR) && sonicHB.velocity.y <= 0){
        if(!isSpindashing && FlxG.keys.justPressed.X){
            sonicSprite.animation.play('rolling');
        }
    }
}