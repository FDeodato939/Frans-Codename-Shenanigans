function postUpdate(elapsed){
    // cameras
    camGame.zoom = lerp(camGame.zoom, defaultCamZoom, 0.08);
    camHUD.zoom = lerp(camHUD.zoom, 1, 0.08);
    // strumLines
    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()){
        case 'singLEFT':
            camFollow.x -= 40;
            camGame.angle = lerp(camGame.angle, -4, 0.1);
        case 'singDOWN':
            camFollow.y += 40;
            camGame.angle = lerp(camGame.angle, 0, 0.1);
        case 'singUP':
            camFollow.y -= 40;
            camGame.angle = lerp(camGame.angle, 0, 0.1);
        case 'singRIGHT':
            camFollow.x += 40;
            camGame.angle = lerp(camGame.angle, 4, 0.1);
        case 'idle':
            camGame.angle = lerp(camGame.angle, 0, 0.1);
    }
}
function beatHit(curBeat){
    if(curBeat >= 0){
        if(curBeat % 4 == 0){
            camGame.zoom += 0.02;
            camHUD.zoom += 0.02;
        }
    }
}
function onCountdown(e){
    e.cancel();
}