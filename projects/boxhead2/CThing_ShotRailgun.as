class CThing_ShotRailgun extends CThing_Shot
{
    var _CLASSID_ = "CThing_ShotRailgun";
    var _BASECLASSID_ = "CThing_ShotRailgun";
    function CThing_ShotRailgun(tPosition, tAngle, tID, tOwner, tDamage)
    {
        super(tPosition,tAngle,tID,tOwner,tDamage);
        var _loc6_ = new scidd.Math.CPointXYZ(1,0,0);
        _loc6_.RotateZ(this.mAngle);
        _loc6_.Normalize(CMapwho.mCellSize.x * 25);
        this.mDestination = this.mPosition.Add(_loc6_);
        this.mLife = 11;
        this.mMaxLife = 11;
        this.mDelta = new scidd.Math.CPointXYZ(0,random(4) + 2,random(4) + 2).RotateZ(this.mAngle);
        this.Move(this.mPosition);
        var _loc3_ = this.oMapwho.mMapwho.LineCollide_CONT(this.mPosition,this.mDestination,this.mID);
        for(var _loc5_ in _loc3_.mThingList)
        {
            var _loc4_ = _loc3_.mThingList[_loc5_];
            _loc4_.AddAffect(CThing_Affect.Bullet(this.mOwner,this,this.mDamage,this.mAngle));
            if(_loc3_.mWallPoint != undefined)
            {
                this.mDestination.mX = _loc3_.mWallPoint.x;
                this.mDestination.mY = _loc3_.mWallPoint.y;
            }
        }
        this.mAlpha = 70;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        this.mDestination = this.mDestination.Add(this.mDelta.Clone().ScaleN(0.5));
        this.mPosition = this.mPosition.Add(this.mDelta.ScaleN(0.75));
        if(--this.mLife == 0)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CCity._this.DrawLine(this.mPosition,this.mDestination,4,9606142,this.mAlpha);
        this.mAlpha -= 10;
    }
}
