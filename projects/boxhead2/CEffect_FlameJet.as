if(!_global.CEffect_FlameJet)
{
    var _loc1_ = null;
    _global.CEffect_FlameJet = function()
    {
        super();
        this.flList = new Array();
        this._Container._Circle._visible = false;
    };
    _global.CEffect_FlameJet extends MovieClip;
    var _loc2_ = _global.CEffect_FlameJet = function()
    {
        super();
        this.flList = new Array();
        this._Container._Circle._visible = false;
    }.prototype;
    _loc2_.__get__mCount = function get mCount()
    {
        return this._Count;
    };
    _loc2_.Process = function Process()
    {
        1703;
        if(this.mActive)
        {
            this.CreateCircle();
        }
        this._Count = 0;
        for(var _loc4_ in this.flList)
        {
            var _loc2_ = this.flList[_loc4_];
            if(!_loc2_.mDelete)
            {
                this._Count++;
                var _loc3_ = _loc2_.mc;
                _loc2_.mPosition = _loc2_.mPosition.add(_loc2_.mDelta);
                _loc3_._x = _loc2_.mPosition.x;
                _loc3_._y = _loc2_.mPosition.y + random(_loc3_._yscale / 6) - _loc3_._yscale / 12;
                _loc3_._xscale = Math.min(_loc3_._xscale + _loc2_.mDelta.x,100);
                _loc3_._yscale = Math.min(_loc3_._yscale + _loc2_.mDelta.x * Math.random(),100);
                _loc2_.mDelta.x += 0.1;
                if(_loc3_._x > CEffect_FlameJet.mScope.mWidth)
                {
                    _loc2_.mDelete = true;
                    _loc3_._visible = false;
                    this.flIndex = Number(_loc4_);
                }
            }
        }
    };
    _loc2_.CreateCircle = function CreateCircle()
    {
        if(this.flIndex == undefined)
        {
            this.flIndex = this.flList.length;
            var _loc2_ = {mPosition:new flash.geom.Point(0,0),mDelta:new flash.geom.Point(10,0)};
            _loc2_.mc = this._Container._Circle.duplicateMovieClip("_Circle" + this.flIndex,this._Container.getNextHighestDepth(),{_xscale:10,_yscale:10});
            this.flList[this.flIndex] = _loc2_;
        }
        else
        {
            _loc2_ = this.flList[this.flIndex];
            _loc2_.mPosition.x = 0;
            _loc2_.mPosition.y = 0;
            _loc2_.mDelta.x = 10;
            _loc2_.mDelta.y = 0;
            _loc2_.mc._visible = true;
            _loc2_.mc._xscale = 10;
            _loc2_.mc._yscale = 10;
            this.flIndex = undefined;
        }
    };
    _loc2_.__set__mDirection = function __set__mDirection(a)
    {
        this._Container._rotation = a * 180 / 3.141592653589793;
        return this.__get__mDirection();
    };
    _loc2_.Draw = 0;
    _loc2_._CLASSID_ = "CEffect_FlameJet";
    _global.CEffect_FlameJet = function()
    {
        super();
        this.flList = new Array();
        this._Container._Circle._visible = false;
    }.mScope = {mHeight:100,mWidth:400};
    §§push(_loc2_.addProperty("mCount",_loc2_.__get__mCount,0));
    §§push(_loc2_.addProperty("mDirection",0,_loc2_.__set__mDirection));
    §§push(ASSetPropFlags(_global.CEffect_FlameJet.prototype,null,1));
}
§§pop();
