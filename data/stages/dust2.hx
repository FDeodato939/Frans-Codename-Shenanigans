// libraries
import flx3d.Flx3DView;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.addons.display.FlxBackdrop;
// functions
function postCreate(){
    // skybox
    skybox = new FlxSprite().loadGraphic(Paths.image('skyboxes/dust2'));
    skybox.scale.set(4, 4);
    skybox.scrollFactor.set();
    skybox.screenCenter();
    // view3D
    view3D = new Flx3DView(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
    view3D.antialiasing = true;
    view3D.scrollFactor.set();
    view3D.screenCenter();
	view3D.view.camera.lens.far = 100000000;
    // setPositions
	gf.setPosition(350, 100);
	dad.setPosition(-100, 0);
	boyfriend.setPosition(900, 0);
    // inserts
    insert(members.indexOf(gf), view3D);
    insert(members.indexOf(dad), view3D);
    insert(members.indexOf(boyfriend), view3D);
    insert(members.indexOf(view3D), skybox);
    // dust2
    add(view3D.addModel(Paths.obj('dust2'), function(model){
        if(Std.string(model.asset.assetType) == 'mesh'){
            model.asset.scale(80);
            model.asset.x = 3000;
            model.asset.y = -350;
            model.asset.z = 800;
            model.asset.rotationX = 90;
        }
    }, Paths.image('tex/dust2'), false));
}
function postUpdate(elapsed){
    view3D.view.camera.x = FlxG.camera.scroll.x / 4.6;
    view3D.view.camera.y = -FlxG.camera.scroll.y / 4.6;
}
function destroy(){
    view3D.destroy();
}