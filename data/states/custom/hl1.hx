// import
import flx3d.Flx3DView;
// variable
static var view3D:Flx3DView;
var isSelected:Bool = false;
// functions
function create(){
    // view3D
    view3D = new Flx3DView(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
    view3D.antialiasing = true;
    view3D.scrollFactor.set();
    view3D.screenCenter();
	view3D.view.camera.lens.far = 100000000;
    add(view3D);
    // nothingBurger
    add(nothingBurger = new FlxSprite().makeGraphic(1, 1));
    insert(nothingBurger, view3D);
    // importScript
    importScript('data/scripts/hl1/anomalousMaterials');
}
function update(elapsed){
    // isSelected
    if(!isSelected){
        if(controls.BACK){
            // sound
            FlxG.sound.play(Paths.sound('menu/cancel'));
            // state
            FlxG.switchState(new MainMenuState());
            // isSelected
            isSelected = true;
        }
    }
    // view3D
    view3D.view.camera.rotationX = FlxG.mouse.y;
    view3D.view.camera.rotationY = FlxG.mouse.x;
    // moving
    if(controls.UP){
        view3D.view.camera.z += 10;
    }
    if(controls.DOWN){
        view3D.view.camera.z -= 10;
    }
    if(controls.LEFT){
        view3D.view.camera.x -= 10;
    }
    if(controls.RIGHT){
        view3D.view.camera.x += 10;
    }
    if(FlxG.keys.pressed.Q){
        view3D.view.camera.y -= 10;
    }
    if(FlxG.keys.pressed.E){
        view3D.view.camera.y += 10;
    }
}
function destroy(){
    view3D.destroy();
}