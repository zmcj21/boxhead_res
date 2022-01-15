if(!_global.scidd)
{
    _global.scidd = new Object();
}
§§pop();
if(!_global.scidd.Draw)
{
    _global.scidd.Draw = new Object();
}
§§pop();
if(!_global.scidd.Draw.F3D)
{
    _global.scidd.Draw.F3D = new Object();
}
§§pop();
if(!_global.scidd.Draw.F3D.CProjection3D)
{
    scidd.Draw.F3D.CProjection3D = 0;
    var _loc2_ = 0.prototype;
    0.Isometric = function(tv_list)
    {
        for(var _loc3_ in tv_list)
        {
            var _loc1_ = tv_list[_loc3_];
            _loc1_.mY += (_loc1_.mX + _loc1_.mZ) * 0.5;
            _loc1_.mX -= _loc1_.mZ;
        }
    };
    0.Perspective = function(tv_list, tlens)
    {
        for(var _loc5_ in tv_list)
        {
            var _loc1_ = tv_list[_loc5_];
            var _loc2_ = _loc1_.mZ;
            _loc1_.mX = tlens * _loc1_.mX / _loc2_;
            _loc1_.mY = tlens * _loc1_.mY / _loc2_;
        }
    };
    _loc2_._CLASSID_ = "scidd.Draw.F3D.CProjection3D";
    _loc2_.mType_Perspective = 1;
    _loc2_.mType_Isometric = 2;
    _loc2_.mType_Pushed = 3;
    _loc2_.mType_TopDown = 4;
    _loc2_.mType = scidd.Draw.F3D.CProjection3D.prototype.mType_Perspective;
    §§push(ASSetPropFlags(scidd.Draw.F3D.CProjection3D.prototype,null,1));
}
§§pop();
