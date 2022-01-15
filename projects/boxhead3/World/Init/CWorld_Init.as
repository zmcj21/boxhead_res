if(!_global.World)
{
    _global.World = new Object();
}
§§pop();
if(!_global.World.Init)
{
    _global.World.Init = new Object();
}
§§pop();
if(!_global.World.Init.CWorld_Init)
{
    var _loc1_ = null;
    World.Init.CWorld_Init = function()
    {
        super();
        this.mWorld = this.FindParent("CWorld");
        this.mWorld.AddInitObject(this);
    };
    World.Init.CWorld_Init extends MovieClip;
    var _loc2_ = World.Init.CWorld_Init = function()
    {
        super();
        this.mWorld = this.FindParent("CWorld");
        this.mWorld.AddInitObject(this);
    }.prototype;
    _loc2_.FindParent = function FindParent(tClassID)
    {
        0;
        var _loc2_ = this._parent;
        while(true)
        {
            if(_loc2_._CLASSID_ == tClassID)
            {
                return _loc2_;
            }
            _loc2_ = _loc2_._parent;
            1;
            0;
        }
        trace("Parent was not found with ClassID " + tClassID);
        return undefined;
    };
    _loc2_.__get__mPosition = function get mPosition()
    {
        var _loc2_ = new flash.geom.Point(0,0);
        this.localToGlobal(_loc2_);
        this.mWorld.globalToLocal(_loc2_);
        return new Thing.Math.CThing_Position(_loc2_.x,_loc2_.y,0);
    };
    _loc2_.__get__mPosition2 = function __get__mPosition2()
    {
        var _loc2_ = this.__get__mPosition();
        return new Thing.Math.CThing_Position(_loc2_.mX + this._width,_loc2_.mY + this._height,0);
    };
    _loc2_.GetPosition = function GetPosition(mc)
    {
        var _loc2_ = new flash.geom.Point(0,0);
        mc.localToGlobal(_loc2_);
        this.mWorld.globalToLocal(_loc2_);
        return new Thing.Math.CThing_Position(_loc2_.x,_loc2_.y,0);
    };
    _loc2_.toString = function toString()
    {
        return this._CLASSID_ + "," + this._x + "," + this._y + "," + this._width + "," + this._height;
    };
    _loc2_.Dispose = function Dispose()
    {
        this.removeMovieClip();
    };
    _loc2_._CLASSID_ = "CWorld_Init";
    _loc2_._BASECLASSID_ = "CWorld_Init";
    §§push(_loc2_.addProperty("mPosition",_loc2_.__get__mPosition,0));
    §§push(_loc2_.addProperty("mPosition2",_loc2_.__get__mPosition2,0));
    §§push(ASSetPropFlags(World.Init.CWorld_Init.prototype,null,1));
}
§§pop();
