function postCreate(){
    add(redVignette = new FlxSprite().loadGraphic(Paths.image('game/redVignette')));
    redVignette.setGraphicSize(FlxG.width, FlxG.height);
    redVignette.antialiasing = true;
    redVignette.screenCenter();
    redVignette.alpha = 0;
    redVignette.cameras = [camHUD];
}
function postUpdate(elapsed){
    redVignette.alpha = lerp(redVignette.alpha, 0, 0.1);
}
function onPlayerMiss(e){
    // blood
    add(blood = new FlxSprite(FlxG.random.int(0, FlxG.width), FlxG.random.int(0, FlxG.height)).loadGraphic(Paths.image('game/blood/blood'+FlxG.random.int(0, 5))));
    blood.scale.set(1.2, 1.2);
    blood.antialiasing = true;
    blood.cameras = [camHUD];
    FlxTween.tween(blood.scale, {x: 1, y: 1}, 2, {ease: FlxEase.quintOut});
    FlxTween.tween(blood, {alpha: 0}, 10, {ease: FlxEase.quintOut, onComplete: function(){
        remove(blood);
    }});
    // redVignette
    redVignette.alpha = 1;
}