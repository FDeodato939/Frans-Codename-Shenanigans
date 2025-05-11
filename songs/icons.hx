static function createIcon(character, x, y){
    // variables
    icon = new FlxSprite(x, y);
    path = 'icons/'+((character != null) ? character.getIcon() : 'face');
    // icon
    if(((character != null && character.xml != null) && character.xml.exists('animatedIcon')) ? (character.xml.get('animatedIcon') == 'true') : false){
        icon.frames = Paths.getSparrowAtlas(path);
        icon.animation.addByPrefix('neutral', 'neutral', 12);
        icon.animation.addByPrefix('losing', 'losing', 12);
        icon.animation.addByPrefix('winning', 'winning', 12);
        icon.animation.play('neutral');
    }else{
        icon.loadGraphic(Paths.image(path), true, Paths.image(path).width/2, Paths.image(path).height);
        icon.animation.add('nonAnimated', [0, 1], 0, false);
        icon.animation.play('nonAnimated');
    }
    if(character.xml.exists('iconScale')){
        icon.scale.set(Std.parseFloat(character.xml.get('iconScale')), Std.parseFloat(character.xml.get('iconScale')));
    }
    icon.antialiasing = character.antialiasing;
    icon.flipX = character.isPlayer;
    icon.updateHitbox();
    // return
    return icon;
}