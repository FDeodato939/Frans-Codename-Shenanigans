// libraries
import flixel.addons.display.FlxBackdrop;
// functions
function create(){
    add(backdropGroup = new FlxGroup());
    for(backdrop in 0...2){
        backdropGroup.add(backdrop = new FlxBackdrop(Paths.image('demos/mario/backdrop')));
        backdrop.scrollFactor.set(0.1, 0.1);
        backdrop.scale.set(0.7, 0.7);
        backdrop.screenCenter();
    }
    backdropGroup.members[0].velocity.set(-3, -3);
    backdropGroup.members[0].alpha = 0.1;
    backdropGroup.members[1].velocity.set(5, 5);
    backdropGroup.members[1].alpha = 0.5;
}