if(!_global.CEffect_Lightning)
{
    var _loc1_ = null;
    _global.CEffect_Lightning = function()
    {
        super();
        this.flList = new Array();
        this.mTargetList = new Array();
    };
    _global.CEffect_Lightning extends MovieClip;
    var _loc2_ = _global.CEffect_Lightning = function()
    {
        super();
        this.flList = new Array();
        this.mTargetList = new Array();
    }.prototype;
    _loc2_.ClearTargetList = function ClearTargetList()
    {
        this.mTargetList = new Array();
    };
    _loc2_.AddToTargetList = function AddToTargetList(p)
    {
        this.mTargetList[this.mTargetList.length] = p;
    };
    _loc2_.Process = function Process()
    {
        this.flList = new Array();
        this.mMatrix = scidd.Math.CMath.GetMatrix_Angle(this.mAngle);
        this.iMatrix = scidd.Math.CMath.GetMatrix_Angle(0 - this.mAngle);
        var _loc2_ = this.mMatrix.transformPoint(CEffect_Lightning.mStartDelta);
        for(var _loc3_ in this.mTargetList)
        {
            this.flList[_loc3_] = this.CreateLightning(this.mTargetList[_loc3_],_loc2_);
        }
    };
    _loc2_.CreateLightning = function CreateLightning(dest, d)
    {
        d.normalize(CEffect_Lightning.mSpeed);
        var _loc2_ = new flash.geom.Point(0,0);
        var _loc7_ = new Array();
        var _loc10_ = 1 / CEffect_Lightning.mScope.mHeight;
        var _loc11_ = dest.length;
        var _loc9_ = this.mMatrix.transformPoint(dest);
        _loc7_[_loc7_.length] = this.iMatrix.transformPoint(_loc2_);
        0;
        while(true)
        {
            var _loc5_ = flash.geom.Point.distance(_loc2_,_loc9_);
            var _loc8_ = Math.min(Math.min(1 - Math.abs(_loc2_.y) * _loc10_,_loc5_ * _loc11_),1);
            d.x += (Math.random() - 0.5) * 20;
            d.y += (Math.random() - 0.5) * 20;
            var _loc6_ = _loc9_.subtract(_loc2_);
            _loc6_.normalize(CEffect_Lightning.mSpeed);
            d = flash.geom.Point.interpolate(d,_loc6_,_loc8_);
            _loc2_ = _loc2_.add(d);
            if(_loc5_ < CEffect_Lightning.mSpeed * 1.5)
            {
                break;
            }
            _loc7_[_loc7_.length] = this.iMatrix.transformPoint(_loc2_);
            1;
        }
        _loc7_[_loc7_.length] = dest;
        return _loc7_;
    };
    _loc2_.Draw = function Draw()
    {
        this._Container.clear();
        for(var _loc3_ in this.flList)
        {
            var _loc2_ = this.flList[_loc3_];
            this._Container.lineStyle(2,16777215,100,false);
            this._Container.moveTo(_loc2_[0].x,_loc2_[0].y);
            1;
            while(1 < _loc2_.length - 1)
            {
                this._Container.lineTo(_loc2_[1].x,_loc2_[1].y);
                2;
            }
            this._Container.lineTo(_loc2_[_loc2_.length - 1].x,_loc2_[_loc2_.length - 1].y);
        }
    };
    _loc2_.__set__mDirection = function __set__mDirection(a)
    {
        this.mAngle = a;
        return this.__get__mDirection();
    };
    _loc2_._CLASSID_ = "CEffect_Lightning";
    _global.CEffect_Lightning = function()
    {
        super();
        this.flList = new Array();
        this.mTargetList = new Array();
    }.mScope = {mHeight:64,mWidth:600};
    _global.CEffect_Lightning = function()
    {
        super();
        this.flList = new Array();
        this.mTargetList = new Array();
    }.mStartDelta = new flash.geom.Point(1,0.25);
    _global.CEffect_Lightning = function()
    {
        super();
        this.flList = new Array();
        this.mTargetList = new Array();
    }.mSpeed = 16;
    §§push(_loc2_.addProperty("mDirection",0,_loc2_.__set__mDirection));
    §§push(ASSetPropFlags(_global.CEffect_Lightning.prototype,null,1));
}
§§pop();
