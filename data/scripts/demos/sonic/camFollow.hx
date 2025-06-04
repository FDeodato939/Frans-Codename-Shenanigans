// libraries
import flixel.util.FlxDirectionFlags;
// functions
function create(){
    add(sonicCamFollow = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT));
}
function update(elapsed){
    // camera
    FlxG.camera.follow(sonicCamFollow);
    // horizontal
    if((sonicHB.velocity.x <= -300) || (sonicHB.velocity.x >= 300)){
        if(isRolling){
            sonicCamFollow.x = lerp(sonicCamFollow.x, sonicHB.x + 10, 0.1);
        }else{
            if(sonicHB.velocity.x >= 300){
                sonicCamFollow.x = lerp(sonicCamFollow.x, sonicHB.x + 120, 0.1);
            }else{
                sonicCamFollow.x = lerp(sonicCamFollow.x, sonicHB.x - 100, 0.1);
            }
        }
    }else{
        sonicCamFollow.x = lerp(sonicCamFollow.x, sonicHB.x + 10, 0.1);
    }
    // vertical
    if((sonicHB.velocity.y >= 0) && sonicHB.isTouching(FlxDirectionFlags.FLOOR)){
        if(isSpindashing){
            sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y, 0.1);
        }else{
            if(sonicHB.velocity.x == 0){
                if(controls.UP){
                    sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y - 60, 0.1);
                }else if(controls.DOWN){
                    sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y + 90, 0.1);
                }else{
                    sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y, 0.1);
                }
            }else{
                sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y, 0.1);
            }
        }
    }else{
        sonicCamFollow.y = lerp(sonicCamFollow.y, sonicHB.y, 0.1);
    }
}