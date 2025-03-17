// libraries
import flx3d.Flx3DView;
// functions
function postCreate(){
    // skybox
    skybox = new FlxSprite().loadGraphic(Paths.image('skyboxes/resortIsland'));
    skybox.scale.set(9, 9);
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
    // resortIsland
    add(view3D.addModel(Paths.obj('resortIsland'), function(model){
        if(Std.string(model.asset.assetType) == 'mesh'){
            model.asset.scale(100);
            model.asset.x = -1650;
            model.asset.y = -250;
            model.asset.z = 3600;
            model.asset.rotationY = -40;
        }
    }, Paths.image('tex/resortIsland'), false));
}
function postUpdate(elapsed){
    view3D.view.camera.x = FlxG.camera.scroll.x / 1.6;
    view3D.view.camera.y = -FlxG.camera.scroll.y / 1.6;
}
function destroy(){
    view3D.destroy();
}