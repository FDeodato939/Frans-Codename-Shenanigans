function postUpdate(elapsed){
    camGame.zoom = lerp(camGame.zoom, defaultCamZoom, 0.05);
    camHUD.zoom = lerp(camHUD.zoom, defaultHudZoom, 0.05);
}
function beatHit(curBeat){
    if(curBeat >= 0){
        if(curBeat % 4 == 0){
            camGame.zoom += 0.015 * camZoomingStrength;
            camHUD.zoom += 0.03 * camZoomingStrength;
        }
    }
}