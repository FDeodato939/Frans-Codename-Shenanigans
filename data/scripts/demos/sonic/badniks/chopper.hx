// library
import flixel.util.FlxDirectionFlags;
// variables
static var chopperHBGroup:FlxSpriteGroup;
// functions
function create(){
    add(chopperHBGroup = new FlxSpriteGroup());
    add(chopperGroup = new FlxSpriteGroup());
    for(i in 0...sonicList.enemies.chopper.length){
        // chopperHBGroup
        chopperHBGroup.add(hitbox = new FlxSprite(sonicList.enemies.chopper[i].position[0], sonicList.enemies.chopper[i].position[1]).makeGraphic(30, 32, 0xffc0000));
        hitbox.updateHitbox();
        hitbox.maxVelocity.y = sonicList.enemies.chopper[i].maxVelocity;
        hitbox.acceleration.y = sonicList.enemies.chopper[i].acceleration;
        hitbox.ID = i;
        // chopperGroup
        chopperGroup.add(sprite = new FlxSprite());
        sprite.frames = Paths.getFrames('demos/sonic/enemies/chopper');
        sprite.animation.addByPrefix('idle', 'idle', 8);
        sprite.animation.play('idle');
        sprite.origin.set(0, 0);
        sprite.ID = i;
    }
}
function update(elapsed){
    // chopperHBGroup
    chopperHBGroup.forEach(function(hitbox){
        // overlap
        FlxG.overlap(sonicHB, hitbox, function(){
            if(sonicSprite.animation.name == 'spindash' || sonicSprite.animation.name == 'rolling'){
                // sound
                FlxG.sound.play(Paths.sound('sonic/destroy'));
                // chopstuff
                for(chopstuff in [hitbox, chopperGroup.members[hitbox.ID]]){
                    chopstuff.kill();
                }
                // jumping
                if(sonicHB.velocity.y > 0){
                    sonicHB.velocity.y = -sonicHB.maxVelocity.y / 2;
                }
                // doExplosion
                doExplosion(hitbox);
            }else{
                // sound
                FlxG.sound.play(Paths.sound('sonic/hurt'));
                // isHurt
                isHurt = true;
                // velocity
                sonicHB.velocity.y = -sonicHB.maxVelocity.y / 2;
                // flipped
                if(sonicSprite.flipX){
                    sonicHB.velocity.x += 500;
                }else{
                    sonicHB.velocity.x -= 500;
                }
            }
        });
        // velocity
        hitbox.velocity.x = 0;
        // jump
        if(hitbox.y >= sonicList.enemies.chopper[hitbox.ID].position[1]){
            hitbox.velocity.y = -hitbox.maxVelocity.y / 2;
        }
    });
    // chopperGroup
    chopperGroup.forEach(function(sprite){
        sprite.setPosition(chopperHBGroup.members[sprite.ID].x, chopperHBGroup.members[sprite.ID].y);
    });
}
function doExplosion(hitbox){
    // explosion
    explosion = new FlxSprite(hitbox.x, hitbox.y);
    explosion.frames = Paths.getFrames('demos/sonic/explosion');
    explosion.animation.addByPrefix('idle', 'idle', 8, false);
    explosion.animation.play('idle');
    // insert
    insert(hitbox, explosion);
    // tween
    FlxTween.tween(explosion, {alpha: 0}, 0.5, {onComplete: function(){
        remove(explosion);
    }});
    // return
    return explosion;
}