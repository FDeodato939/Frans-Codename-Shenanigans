// libraries
import flixel.util.FlxDirectionFlags;
// variables
static var marioHB:FlxSprite;
// functions
function create(){
    // marioHB
    add(marioHB = new FlxSprite(30, -50).makeGraphic(11, 15, 0xaaf84070));
    marioHB.updateHitbox();
    marioHB.maxVelocity.set(120, 360);
    marioHB.acceleration.y = 350;
    marioHB.drag.x = (marioHB.maxVelocity.x * 4);
    // marioSprite
    add(marioSprite = new FlxSprite());
	marioSprite.frames = Paths.getFrames('demos/mario/mario');
	marioSprite.animation.addByPrefix('idle', 'idle', 0);
	marioSprite.animation.addByPrefix('down', 'down', 0);
	marioSprite.animation.addByPrefix('downHolding', 'downHolding');
	marioSprite.animation.addByPrefix('up', 'up', 0);
	marioSprite.animation.addByPrefix('upHolding', 'upHolding');
	marioSprite.animation.addByPrefix('idleHolding', 'idleHolding');
	marioSprite.animation.addByPrefix('jumping', 'jumping');
	marioSprite.animation.addByPrefix('walking', 'walking', 16);
	marioSprite.animation.addByPrefix('walkHolding', 'walkHolding', 16);
	marioSprite.animation.addByPrefix('running', 'running', 16);
	marioSprite.animation.addByPrefix('jumping', 'jumping');
	marioSprite.animation.addByPrefix('jumpRunning', 'jumpRunning');
	marioSprite.animation.addByPrefix('swimming', 'swimming');
	marioSprite.animation.addByPrefix('swimHolding', 'swimHolding');
	marioSprite.animation.addByPrefix('falling', 'falling');
	marioSprite.animation.addByPrefix('sliding', 'sliding');
	marioSprite.animation.addByPrefix('spinJump', 'spinJump', 16);
	marioSprite.animation.addByPrefix('victory', 'victory');
	marioSprite.animation.play('idle');
    marioSprite.flipX = true;
    marioSprite.origin.set(0, 0);
}
function update(elapsed){
    // moving
    if(controls.LEFT){
        marioSprite.flipX = false;
        marioHB.velocity.x -= 10;
    }
    if(controls.RIGHT){
        marioSprite.flipX = true;
        marioHB.velocity.x += 10;
    }
    // running
    if(FlxG.keys.pressed.Z){
        marioHB.maxVelocity.x = 180;
    }else{
        marioHB.maxVelocity.x = 120;
    }
    // ground
    if((marioHB.velocity.y >= 0) && marioHB.isTouching(FlxDirectionFlags.FLOOR)){
        // jumping
        if(FlxG.keys.justPressed.X){
            // velocity
            marioHB.velocity.y = -marioHB.maxVelocity.y / 2;
            // animation
            marioSprite.animation.play('jumping');
        }
        // spinJump
        if(FlxG.keys.justPressed.C){
            // velocity
            marioHB.velocity.y = -marioHB.maxVelocity.y / 2;
            // animation
            marioSprite.animation.play('spinJump');
        }
    }
    // flipped
    if(marioSprite.flipX){
        marioSprite.setPosition(marioHB.x - 10, marioHB.y - 25);
    }else{
        marioSprite.setPosition(marioHB.x - 9, marioHB.y - 25);
    }
    // animation
    if((marioHB.velocity.y >= 0) && marioHB.isTouching(FlxDirectionFlags.FLOOR)){
        if((marioHB.velocity.x < 0 || marioHB.velocity.x > 0) && !marioHB.isTouching(FlxDirectionFlags.WALL)){
            if((marioHB.velocity.x <= -180) || (marioHB.velocity.x >= 180)){
                marioSprite.animation.play('running');
            }else{
                marioSprite.animation.play('walking');
            }
        }else{
            if(controls.UP){
                marioSprite.animation.play('up');
            }else if(controls.DOWN){
                marioSprite.animation.play('down');
            }else{
                marioSprite.animation.play('idle');
            }
        }
    }else{
        if(marioSprite.animation.name == 'jumping' || marioSprite.animation.name == 'jumpRunning'){
            if((marioHB.velocity.x <= -180) || (marioHB.velocity.x >= 180)){
                marioSprite.animation.play('jumpRunning');
            }else{
                marioSprite.animation.play('jumping');
            }
        }
    }
}