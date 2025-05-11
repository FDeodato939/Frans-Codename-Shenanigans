// libraries
import flixel.util.FlxDirectionFlags;
import flixel.text.FlxTextBorderStyle;
// variables
static var sonicHB:FlxSprite;
static var sonicSprite:FlxSprite;
static var isRolling:Bool = false;
static var isSpindashing:Bool = false;
static var isHurt:Bool = false;
static var spinVelocity:Int = 0;
// function
function create(){
    // isRolling
    isRolling = false;
    // isSpindashing
    isSpindashing = false;
    // isHurt
    isHurt = false;
    // spinVelocity
    spinVelocity = 0;
    // sonicHB
    add(sonicHB = new FlxSprite(35, -30).makeGraphic(22, 28, 0xf6c6cfc));
    sonicHB.updateHitbox();
    sonicHB.maxVelocity.set(300, 760);
    sonicHB.acceleration.y = 750;
    sonicHB.drag.x = sonicHB.maxVelocity.x;
    // sonicSprite
    add(sonicSprite = new FlxSprite());
	sonicSprite.frames = Paths.getFrames('minigames/sonic/characters/sonic');
	sonicSprite.animation.addByPrefix('idle', 'idle');
	sonicSprite.animation.addByPrefix('bounced', 'bounced');
	sonicSprite.animation.addByPrefix('hurt', 'hurt', 8);
	sonicSprite.animation.addByPrefix('death', 'death');
	sonicSprite.animation.addByPrefix('up', 'up', 12, false);
	sonicSprite.animation.addByPrefix('down', 'down', 12, false);
	sonicSprite.animation.addByPrefix('holding', 'holding', 12);
	sonicSprite.animation.addByPrefix('spindash', 'spindash', 16);
	sonicSprite.animation.addByPrefix('walking', 'walking', 12);
	sonicSprite.animation.addByPrefix('running', 'running', 16);
	sonicSprite.animation.addByPrefix('rolling', 'rolling', 16);
	sonicSprite.animation.addByPrefix('peelOut', 'peelOut', 16);
	sonicSprite.animation.play('idle');
    sonicSprite.origin.set(0, 0);
}
function update(elapsed){
    // isHurt
    if(isHurt){
        // isTouching
        if(sonicHB.isTouching(FlxDirectionFlags.FLOOR)){
            isHurt = false;
        }
        // animation
        sonicSprite.animation.play('hurt');
    }else{
        // not rolling and spindashing
        if(!isRolling && !isSpindashing){
            // maxVelocity
            sonicHB.maxVelocity.x = 300;
            // moving
            if(controls.LEFT){
                sonicHB.velocity.x -= 5;
                sonicSprite.flipX = true;
            }
            if(controls.RIGHT){
                sonicHB.velocity.x += 5;
                sonicSprite.flipX = false;
            }
        }
        // ground
        if((sonicHB.velocity.y >= 0) && sonicHB.isTouching(FlxDirectionFlags.FLOOR)){
            if(sonicHB.velocity.x < 0 || sonicHB.velocity.x > 0){
                if(controls.DOWN_P){
                    // sound
                    FlxG.sound.play(Paths.sound('sonic/roll'));
                    // isRolling
                    isRolling = true;
                }
            }else{
                if(controls.DOWN){
                    if(FlxG.keys.justPressed.X){
                        // sound
                        FlxG.sound.play(Paths.sound('sonic/charge'));
                        // isSpindashing
                        isSpindashing = true;
                    }
                }
            }
        }
        // rolling
        if(sonicHB.velocity.x == 0){
            isRolling = false;
        }
        // spindash
        if(isSpindashing){
            // controls
            if(controls.DOWN){
                if(FlxG.keys.justPressed.X){
                    if(spinVelocity < sonicHB.maxVelocity.x){
                        spinVelocity += 100;
                    }
                }
            }else{
                // isRolling
                isRolling = true;
                // isSpindashing
                isSpindashing = false;
                // flipped
                if(sonicSprite.flipX){
                    sonicHB.velocity.x -= spinVelocity;
                }else{
                    sonicHB.velocity.x += spinVelocity;
                }
                // spinVelocity
                spinVelocity = 0;
            }
            // maxVelocity
            sonicHB.maxVelocity.x = 400;
        }else{
            if((sonicHB.velocity.y >= 0) && sonicHB.isTouching(FlxDirectionFlags.FLOOR)){
                if(FlxG.keys.justPressed.X){
                    // sound
                    FlxG.sound.play(Paths.sound('sonic/jump'));
                    // isRolling
                    isRolling = false;
                    // velocity
                    sonicHB.velocity.y = -sonicHB.maxVelocity.y / 2;
                    // animation
                    sonicSprite.animation.play('rolling');
                }
            }
        }
    }
    // flipped
    if(sonicSprite.flipX){
        sonicSprite.setPosition(sonicHB.x - 12, sonicHB.y - 22);
    }else{
        sonicSprite.setPosition(sonicHB.x - 16, sonicHB.y - 22);
    }
    // animation
    if((sonicHB.velocity.y >= 0) && sonicHB.isTouching(FlxDirectionFlags.FLOOR)){
        if((sonicHB.velocity.x < 0 || sonicHB.velocity.x > 0) && !sonicHB.isTouching(FlxDirectionFlags.WALL)){
            if(isRolling){
                sonicSprite.animation.play('rolling');
            }else{
                if((sonicHB.velocity.x <= -300) || (sonicHB.velocity.x >= 300)){
                    sonicSprite.animation.play('running');
                }else{
                    sonicSprite.animation.play('walking');
                }
            }
        }else{
            if(isSpindashing){
                sonicSprite.animation.play('spindash');
            }else{
                if(controls.UP){
                    if(!sonicSprite.animation.finished){
                        sonicSprite.animation.play('up');
                    }
                }else if(controls.DOWN){
                    if(!sonicSprite.animation.finished){
                        sonicSprite.animation.play('down');
                    }
                }else{
                    sonicSprite.animation.play('idle');
                }
            }
        }
    }
}