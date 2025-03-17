// import
import flx3d.Flx3DView;
import flixel.addons.display.FlxStarField.FlxStarField2D;
// functions
function postCreate(){
    // stars
    stars = new FlxStarField2D(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
    stars.bgColor = FlxColor.TRANSPARENT;
    stars.scrollFactor.set();
    stars.screenCenter();
    stars.setStarSpeed(60, 160);
    // view3D
    view3D = new Flx3DView(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
    view3D.antialiasing = true;
    view3D.scrollFactor.set();
    view3D.screenCenter();
	view3D.view.camera.lens.far = 100000000;
    // setPositions
	gf.setPosition(1850, 150);
	dad.setPosition(-1000, 70);
	boyfriend.setPosition(1650, 70);
    // insets
    insert(members.indexOf(gf), view3D);
    insert(members.indexOf(dad), view3D);
    insert(members.indexOf(boyfriend), view3D);
    insert(members.indexOf(view3D), stars);
    // dsi
    add(view3D.addModel(Paths.obj('dsi'), function(model){
        if(Std.string(model.asset.assetType) == 'mesh'){
            model.asset.scale(50);
            model.asset.y = -2000;
            model.asset.z = 1000;
        }
    }, Paths.image('tex/dsi'), false));
    // nothingBurger
    add(nothingBurger = new FlxSprite().makeGraphic(1, 1));
    insert(nothingBurger, view3D);
}
function postUpdate(elapsed){
    view3D.view.camera.x = FlxG.camera.scroll.x;
    view3D.view.camera.y = -FlxG.camera.scroll.y;
}
function destroy(){
    view3D.destroy();
}