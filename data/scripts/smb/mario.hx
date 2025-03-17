// library
import flixel.util.FlxDirectionFlags;
// variable
static var marioHB:FlxSprite;
// functions
function create(){
    // marioHB
    add(marioHB = new FlxSprite(290, 210).makeGraphic(16, 32, 0xfea9e22));
    marioHB.updateHitbox();
    marioHB.maxVelocity.set(250, 450);
    marioHB.acceleration.y = 340;
    marioHB.drag.x = marioHB.maxVelocity.x;
    // marioSprite
    add(marioSprite = new FlxSprite());
	marioSprite.frames = Paths.getFrames('smb/mario');
	marioSprite.animation.addByPrefix('idle', 'idle');
	marioSprite.animation.addByPrefix('crouch', 'crouch');
	marioSprite.animation.addByPrefix('moving', 'moving', 12);
	marioSprite.animation.addByPrefix('jump', 'jump');
	marioSprite.animation.play('idle');
    marioSprite.origin.set(0, 0);
}
function update(elapsed){
    // isTouching
    if(marioHB.isTouching(FlxDirectionFlags.FLOOR) && marioHB.velocity.y >= 0){
        if(!controls.DOWN){
            if(FlxG.keys.pressed.Z){
                marioHB.maxVelocity.x = 250;
                if(controls.LEFT){
                    marioHB.velocity.x -= 35;
                }
                if(controls.RIGHT){
                    marioHB.velocity.x += 35;
                }
            }else{
                marioHB.maxVelocity.x = 150;
                if(controls.LEFT){
                    marioHB.velocity.x -= 15;
                }
                if(controls.RIGHT){
                    marioHB.velocity.x += 15;
                }
            }
        }
    }else{
        if(FlxG.keys.pressed.Z){
            marioHB.maxVelocity.x = 250;
            if(controls.LEFT){
                marioHB.velocity.x -= 35;
            }
            if(controls.RIGHT){
                marioHB.velocity.x += 35;
            }
        }else{
            marioHB.maxVelocity.x = 150;
            if(controls.LEFT){
                marioHB.velocity.x -= 15;
            }
            if(controls.RIGHT){
                marioHB.velocity.x += 15;
            }
        }
    }
    // jumping
    if(marioHB.isTouching(FlxDirectionFlags.FLOOR) && marioHB.velocity.y >= 0){
        if(FlxG.keys.justPressed.X){
            marioHB.velocity.y = -marioHB.maxVelocity.y / 2;
        }
    }
    // marioSprite
    marioSprite.setPosition(marioHB.x, marioHB.y);
    // flipX
    if(controls.LEFT){
        marioSprite.flipX = true;
    }
    if(controls.RIGHT){
        marioSprite.flipX = false;
    }
    // animations
    if(marioHB.isTouching(FlxDirectionFlags.FLOOR) && marioHB.velocity.y >= 0){
        if(!marioHB.isTouching(FlxDirectionFlags.WALL) && (marioHB.velocity.x < 0 || marioHB.velocity.x > 0)){
            marioSprite.animation.play('moving');
        }else{
            if(controls.DOWN){
                marioSprite.animation.play('crouch');
            }else{
                marioSprite.animation.play('idle');
            }
        }
    }else if(marioHB.isTouching(FlxDirectionFlags.FLOOR) && marioHB.velocity.y <= 0){
        if(FlxG.keys.justPressed.X){
            marioSprite.animation.play('jump');
        }
    }
}