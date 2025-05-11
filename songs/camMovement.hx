function postCreate(){
    FlxG.camera.focusOn(strumLines.members[curCameraTarget].characters[0].getCameraPosition());
}
function postUpdate(elapsed){
    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()){
        case 'singLEFT':
            camFollow.x -= 20;
            camGame.angle = lerp(camGame.angle, -2, 0.1);
        case 'singDOWN':
            camFollow.y += 20;
        case 'singUP':
            camFollow.y -= 20;
        case 'singRIGHT':
            camFollow.x += 20;
            camGame.angle = lerp(camGame.angle, 2, 0.1);
        default:
            camGame.angle = lerp(camGame.angle, 0, 0.1);
    }
}