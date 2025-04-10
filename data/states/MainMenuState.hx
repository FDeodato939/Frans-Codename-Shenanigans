function postUpdate(elapsed){
    if(FlxG.keys.justPressed.H){
        FlxG.switchState(new ModState('custom/hl1'));
    }
    if(FlxG.keys.justPressed.M){
        FlxG.switchState(new ModState('custom/smb'));
    }
    if(FlxG.keys.justPressed.S){
        FlxG.switchState(new ModState('custom/sonic'));
    }
}