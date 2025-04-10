// labrary
import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxStringUtil;
// function
function postCreate(){
    // remove
    for(funkinUI in [comboGroup, healthBar, healthBarBG, iconP2, iconP1, scoreTxt, missesTxt, accuracyTxt]){
        remove(funkinUI);
    }
    // timeBarBG
    add(timeBarBG = new FlxSprite(437, 15).makeGraphic(400, 20, 0xff000000));
    timeBarBG.cameras = [camHUD];
    // timeBar
    add(timeBar = new FlxBar(timeBarBG.x + 5, timeBarBG.y + 5, FlxBarFillDirection.LEFT_TO_RIGHT, timeBarBG.width - 10, timeBarBG.height - 10, inst, 'time', 0, inst.length));
    timeBar.createFilledBar(0xff000000, 0xffffffff);
    timeBar.numDivisions = timeBar.width;
    timeBar.cameras = [camHUD];
    // timeTxt
    add(timeTxt = new FlxText(0, 8, FlxG.width, '0:00', 32));
    timeTxt.font = Paths.font('vcr.ttf');
    timeTxt.alignment = 'center';
    timeTxt.borderStyle = FlxTextBorderStyle.OUTLINE;
    timeTxt.borderSize = 3;
    timeTxt.cameras = [camHUD];
    // opponentIcon
    add(opponentIcon = new HealthIcon(dad.getIcon(), false));
    opponentIcon.setPosition(10, 580);
    opponentIcon.antialiasing = true;
    opponentIcon.cameras = [camHUD];
    // opponentBarBG
    add(opponentBarBG = new FlxSprite(65, 195).makeGraphic(20, 400, 0xff000000));
    opponentBarBG.cameras = [camHUD];
    // opponentBar
    add(opponentBar = new FlxBar(opponentBarBG.x + 5, opponentBarBG.y + 5, FlxBarFillDirection.TOP_TO_BOTTOM, opponentBarBG.width - 10, opponentBarBG.height - 10, this, 'health', 0, maxHealth));
    opponentBar.createFilledBar(dad.iconColor, 0xff000000);
    opponentBar.numDivisions = opponentBar.height;
    opponentBar.cameras = [camHUD];
    // playerIcon
    add(playerIcon = new HealthIcon(boyfriend.getIcon(), true));
    playerIcon.setPosition(1110, 580);
    playerIcon.antialiasing = true;
    playerIcon.cameras = [camHUD];
    // playerBarBG
    add(playerBarBG = new FlxSprite(1185, 195).makeGraphic(20, 400, 0xff000000));
    playerBarBG.cameras = [camHUD];
    // playerBar
    add(playerBar = new FlxBar(playerBarBG.x + 5, playerBarBG.y + 5, FlxBarFillDirection.BOTTOM_TO_TOP, playerBarBG.width - 10, playerBarBG.height - 10, this, 'health', 0, maxHealth));
    playerBar.createFilledBar(0xff000000, boyfriend.iconColor);
    playerBar.numDivisions = playerBar.height;
    playerBar.cameras = [camHUD];
}
function postUpdate(elapsed){
    // strumLines
    for(strumMembers in strumLines.members){
        for(strumNotes in strumMembers.members){
            strumNotes.y = lerp(strumNotes.y, 50, 0.3);
        }
    }
    // icons
    for(icons in [opponentIcon, playerIcon]){
        icons.scale.set(lerp(icons.scale.x, 1, 0.3), lerp(icons.scale.y, 1, 0.3));
        icons.angle = lerp(icons.angle, 0, 0.3);
    }
    // timeTxt
    timeTxt.text = FlxStringUtil.formatTime((inst.length / 1000) - (inst.time / 1000));
    // opponentIcon
    opponentIcon.setPosition(lerp(opponentIcon.x, 10, 0.3), lerp(opponentIcon.y, 580, 0.3));
    // playerIcon
    playerIcon.setPosition(lerp(playerIcon.x, 1110, 0.3), lerp(playerIcon.y, 580, 0.3));
}
function onDadHit(e){
    // cpuStrums
    cpuStrums.members[e.direction].y -= 20;
    // direction
    switch(e.direction){
        case 0:
            opponentIcon.angle -= 10;
            opponentIcon.x -= 10;
        case 1:
            opponentIcon.y += 10;
        case 2:
            opponentIcon.y -= 10;
        case 3:
            opponentIcon.angle += 10;
            opponentIcon.x += 10;
    }
    opponentIcon.scale.set(1.3, 1.3);
}
function onPlayerHit(e){
    // playerStrums
    playerStrums.members[e.direction].y -= 20;
    // direction
    switch(e.direction){
        case 0:
            playerIcon.angle -= 10;
            playerIcon.x -= 10;
        case 1:
            playerIcon.y += 10;
        case 2:
            playerIcon.y -= 10;
        case 3:
            playerIcon.angle += 10;
            playerIcon.x += 10;
    }
    playerIcon.scale.set(1.3, 1.3);
}
function onPlayerMiss(e){
    maxHealth -= 0.02;
}
function beatHit(curBeat){
    for(icons in [opponentIcon, playerIcon]){
        icons.scale.set(1.3, 1.31);
    }
}