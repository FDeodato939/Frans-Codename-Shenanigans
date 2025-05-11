// library
import flixel.util.FlxDirectionFlags;
// variables
static var motobugHBGroup:FlxSpriteGroup;
// functions
function create(){
    add(motobugHBGroup = new FlxSpriteGroup());
    add(motobugGroup = new FlxSpriteGroup());
    for(i in 0...sonicList.enemies.motobug.length){
        // motobugHBGroup
        motobugHBGroup.add(hitbox = new FlxSprite(sonicList.enemies.motobug[i].position[0], sonicList.enemies.motobug[i].position[1]).makeGraphic(40, 29, 0xffc0000));
        hitbox.updateHitbox();
        hitbox.maxVelocity.set(50, 760);
        hitbox.acceleration.y = 750;
        hitbox.drag.x = hitbox.maxVelocity.x;
        hitbox.ID = i;
        // motobugGroup
        motobugGroup.add(sprite = new FlxSprite());
        sprite.frames = Paths.getFrames('minigames/sonic/enemies/motobug');
        sprite.animation.addByPrefix('idle', 'idle', 8);
        sprite.animation.play('idle');
        sprite.origin.set(0, 0);
        sprite.ID = i;
    }
}
function update(elapsed){
    // motobugHBGroup
    motobugHBGroup.forEach(function(hitbox){
        // overlap
        FlxG.overlap(sonicHB, hitbox, function(){
            if(sonicSprite.animation.name == 'spindash' || sonicSprite.animation.name == 'rolling'){
                // sound
                FlxG.sound.play(Paths.sound('sonic/destroy'));
                // motostuff
                for(motostuff in [hitbox, motobugGroup.members[hitbox.ID]]){
                    motostuff.kill();
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
        // moving
        if(motobugGroup.members[hitbox.ID].flipX){
            hitbox.velocity.x += 5;
        }else{
            hitbox.velocity.x -= 5;
        }
        // flipped
        if(hitbox.justTouched(FlxDirectionFlags.WALL)){
            if(motobugGroup.members[hitbox.ID].flipX){
                motobugGroup.members[hitbox.ID].flipX = false;
            }else{
                motobugGroup.members[hitbox.ID].flipX = true;
            }
        }
    });
    // motobugGroup
    motobugGroup.forEach(function(sprite){
        sprite.setPosition(motobugHBGroup.members[sprite.ID].x, motobugHBGroup.members[sprite.ID].y);
    });
}
function doExplosion(hitbox){
    // explosion
    explosion = new FlxSprite(hitbox.x, hitbox.y);
    explosion.frames = Paths.getFrames('minigames/sonic/effects/explosion');
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