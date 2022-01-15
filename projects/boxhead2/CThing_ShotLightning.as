class CThing_ShotLightning extends CThing_Shot
{
    var _CLASSID_ = "CThing_ShotLightning";
    var _BASECLASSID_ = "CThing_ShotLightning";
    static var mRange = 500;
    static var mTargetAmount = 1;
    static var mAngleDiff = 0.7853981633974483;
    function CThing_ShotLightning(tPosition, tAngle, tID, tOwner, tDamage)
    {
        super(tPosition,tAngle,tID,tOwner,tDamage);
        CThing_ShotLightning.mcDraw = CCity._this.AttachScratchMC(this,"Effect_Lightning");
        CThing_ShotLightning.mcDraw.mScale = 1;
        CThing_ShotLightning.mcDraw._visible = true;
        var _loc3_ = new scidd.Math.CPointXYZ(1,0,0);
        _loc3_.RotateZ(this.mAngle);
        _loc3_.Normalize(CMapwho.mCellSize.x * 25);
        this.mDestination = this.mPosition.Add(_loc3_);
        this.mLife = 11;
        this.mMaxLife = 11;
        this.mDelta = new scidd.Math.CPointXYZ(0,random(4) + 2,random(4) + 2).RotateZ(this.mAngle);
        this.Move(this.mPosition);
        this.mDamage = 10;
    }
    function Dispose()
    {
        CThing_ShotLightning.mcDraw._visible = false;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        CThing_ShotLightning.mcDraw.Process();
        CThing_ShotLightning.mcDraw.mDirection = this.mOwner.mAngle;
        CCity._this.UpdateMCPosition(this.mOwner.GetWeaponPosition(),CThing_ShotLightning.mcDraw);
        var _loc5_ = new scidd.Math.CPointXYZ(CThing_ShotLightning.mRange / 2,0,0).RotateZ(this.mOwner.mAngle);
        CEffect_Lightning.mStartDelta = new flash.geom.Point(_loc5_.mX,_loc5_.mY);
        var _loc3_ = this.oMapwho.mMapwho.CircleCollide(this.mPosition.Add(_loc5_),CThing_ShotLightning.mRange / 2,this.mOwner.mID);
        for(var _loc6_ in _loc3_)
        {
            var _loc4_ = _loc3_[_loc6_];
            _loc4_.mTag = (Math.abs(this.mPosition.mX - _loc4_.mPosition.mX) + Math.abs(this.mPosition.mY - _loc4_.mPosition.mY)) * 0.5;
        }
        _loc3_.sortOn("mTag",Array.DESCENDING | Array.NUMERIC);
        var _loc2_ = new Array();
        for(_loc6_ in _loc3_)
        {
            _loc4_ = _loc3_[_loc6_];
            var _loc7_ = this.oMapwho.mMapwho.LineCollide(this.mPosition,_loc4_.mPosition,this.mID);
            if(_loc4_ == _loc7_.mThing)
            {
                _loc2_[_loc2_.length] = _loc4_;
                if(_loc2_.length >= CThing_ShotLightning.mTargetAmount)
                {
                    break;
                }
            }
        }
        CThing_ShotLightning.mcDraw.ClearTargetList();
        if(_loc2_.length < 0)
        {
            _loc7_ = this.oMapwho.mMapwho.LineCollide(this.mPosition,this.mPosition.Add(_loc5_.ScaleN(2)),this.mID);
            if(_loc7_.mWallPoint != undefined)
            {
                CThing_ShotLightning.mcDraw.AddToTargetList(new flash.geom.Point(_loc7_.mWallPoint.x - this.mPosition.mX,_loc7_.mWallPoint.y - this.mPosition.mY));
            }
        }
        else
        {
            for(_loc6_ in _loc2_)
            {
                _loc4_ = _loc2_[_loc6_];
                CThing_ShotLightning.mcDraw.AddToTargetList(new flash.geom.Point(_loc4_.mPosition.mX - this.mPosition.mX,_loc4_.mPosition.mY - this.mPosition.mY));
            }
        }
    }
    function Draw()
    {
        CThing_ShotLightning.mcDraw.Draw();
        CCity._RenderScratch = true;
    }
}
