// libraries
import flixel.util.FlxDirectionFlags;
import flixel.text.FlxTextBorderStyle;
// variables
static var marioHB:FlxSprite;
// functions
function create(){
    // marioHB
    add(marioHB = new FlxSprite(60, 227).makeGraphic(14, 27, 0xffb53120));
    marioHB.maxVelocity.set(120, 360);
    marioHB.acceleration.y = 350;
    marioHB.drag.x = marioHB.maxVelocity.x * 4;
    // marioSprite
    add(marioSprite = new FlxSprite());
	marioSprite.frames = Paths.getFrames('overworld/mario');
	marioSprite.animation.addByPrefix('idle', 'idle', 0);
	marioSprite.animation.addByPrefix('crouching', 'crouching');
	marioSprite.animation.addByPrefix('walking', 'walking', 12);
	marioSprite.animation.addByPrefix('running', 'running', 12);
	marioSprite.animation.addByPrefix('jump', 'jump', 0);
	marioSprite.animation.addByPrefix('jumpRunning', 'jumpRunning', 0);
	marioSprite.animation.play('idle');
    marioSprite.origin.set(0, 0);
    // marioInfo
    add(marioInfo = new FlxText(0, 0, FlxG.width, 'NULL', 12));
    marioInfo.alignment = 'right';
    marioInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    marioInfo.borderSize = 3;
    marioInfo.cameras = [overworldCam];
}
function update(elapsed){
    // isFreeplayOpen
    if(isFreeplayOpen){
        marioSprite.animation.play('idle');
    }else{
        // moving
        if(controls.LEFT){
            marioHB.velocity.x -= 10;
        }
        if(controls.RIGHT){
            marioHB.velocity.x += 10;
        }
        // running
        if(FlxG.keys.pressed.Z){
            marioHB.maxVelocity.x = 180;
        }else{
            marioHB.maxVelocity.x = 120;
        }
        // jumping
        if((marioHB.velocity.y >= 0) && marioHB.isTouching(FlxDirectionFlags.FLOOR)){
            if(FlxG.keys.justPressed.X){
                // animation
                marioSprite.animation.play('jump');
                // velocity
                marioHB.velocity.y = -marioHB.maxVelocity.y / 2;
            }
        }
        // flipX
        if(controls.LEFT){
            marioSprite.flipX = true;
        }
        if(controls.RIGHT){
            marioSprite.flipX = false;
        }
    }
    // marioSprite
    marioSprite.setPosition(marioHB.x - 8, marioHB.y - 3);
    // animation
    if((marioHB.velocity.y >= 0) && marioHB.isTouching(FlxDirectionFlags.FLOOR)){
        if((marioHB.velocity.x < 0 || marioHB.velocity.x > 0) && !marioHB.isTouching(FlxDirectionFlags.WALL)){
            if((marioHB.velocity.x <= -180) || (marioHB.velocity.x >= 180)){
                marioSprite.animation.play('running');
            }else{
                marioSprite.animation.play('walking');
            }
        }else{
            marioSprite.animation.play('idle');
        }
    }else{
        if(marioSprite.animation.name == 'jump' || marioSprite.animation.name == 'jumpRunning'){
            if((marioHB.velocity.x <= -180) || (marioHB.velocity.x >= 180)){
                marioSprite.animation.play('jumpRunning');
            }else{
                marioSprite.animation.play('jump');
            }
        }
    }
    // marioInfo
    marioInfo.text = 'X: '+Std.int(marioHB.x)+'\nY: '+Std.int(marioHB.y)+'\nVelocity: '+Std.int(marioHB.velocity.x)+'\nGravity: '+Std.int(marioHB.velocity.y);
}