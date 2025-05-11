// variable
var data:Map<{lastNote: {time:Float, data:Int}}> = [];
// functions
function postCreate(){
    for(i in strumLines.members){
        data[strumLines.members.indexOf(i)] = {lastNote: {strumTime: -9999, noteData: -1}};
    }
}
function onNoteHit(e){
    // variables
    var target = data[strumLines.members.indexOf(e.note.strumLine)];
    var trail = (e.note.strumTime - target.lastNote.time) <= 2 && e.note.noteData != target.lastNote.data;
    target.lastNote.time = e.note.strumTime;
    target.lastNote.data = e.note.noteData;
    // isSustainNote
    if(!e.note.isSustainNote){
        if(trail){
            for(character in e.characters){
                doTrailAnim(character);
            }
        }
    }
}
function doTrailAnim(char){
    if(char.visible){
        trail = new Character(char.x, char.y, char.curCharacter, char.isPlayer);
        trail.playAnim(char.getAnimName(), true);
        if(char.color != FlxColor.BLACK){
            trail.color = char.iconColor;
        }else{
            trail.color = FlxColor.BLACK;
        }
        insert(members.indexOf(char), trail);
        // tween
        FlxTween.tween(trail, {alpha: 0}, 0.5, {onComplete: function(){
            remove(trail);
        }});
        // return
        return trail;
    }
}