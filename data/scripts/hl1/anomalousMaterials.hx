// import
import flx3d.Flx3DView;
// variable
static var anomalousMaterials;
// functions
function create(){
    view3D.addModel(Paths.obj('anomalousMaterials'), function(model){
        if(Std.string(model.asset.assetType) == 'mesh'){
            model.asset.scale(370);
            model.asset.y = 1300;
            model.asset.z = -1600;
            anomalousMaterials = model.asset;
        }
    }, Paths.image('tex/anomalousMaterials'), false);
}