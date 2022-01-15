class CThing_ShotFlameThrower extends CThing_Shot
{
    var _CLASSID_ = "CThing_ShotFlameThrower";
    var _BASECLASSID_ = "CThing_ShotFlameThrower";
    static var mRange = 500;
    static var mTargetAmount = 1;
    static var mAngleDiff = 0.7853981633974483;
    function CThing_ShotFlameThrower(tPosition, tAngle, tID, tOwner, tDamage)
    {
        super(tPosition,tAngle,tID,tOwner,tDamage);
        CThing_ShotFlameThrower.mcDraw = CCity._this.AttachScratchMC(this,"Effect_FlameJet");
        CThing_ShotFlameThrower.mcDraw.mScale = 1;
        CThing_ShotFlameThrower.mcDraw._visible = true;
        CThing_ShotFlameThrower.mcDraw.mActive = true;
        this.mLife = 11;
        this.mMaxLife = 11;
        this.mDelta = new scidd.Math.CPointXYZ(0,random(4) + 2,random(4) + 2).RotateZ(this.mAngle);
        this.Move(this.mPosition);
        this.mDamage = 10;
    }
    function Stop()
    {
        CThing_ShotFlameThrower.mcDraw.mActive = false;
    }
    function Dispose()
    {
        CThing_ShotFlameThrower.mcDraw._visible = false;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        var _loc5_ = new scidd.Math.CPointXYZ(CMapwho.mCellSize.x * 25,0,0);
        _loc5_.RotateZ(this.mAngle);
        this.mDestination = this.mPosition.Add(_loc5_);
        var _loc2_ = this.oMapwho.mMapwho.LineCollide_CONT(this.mPosition,this.mDestination,this.mID);
        for(var _loc4_ in _loc2_.mThingList)
        {
            var _loc3_ = _loc2_.mThingList[_loc4_];
            if(_loc2_.mWallPoint != undefined)
            {
                this.mDestination.mX = _loc2_.mWallPoint.x;
                this.mDestination.mY = _loc2_.mWallPoint.y;
            }
        }
        CEffect_FlameJet.mScope.mWidth = Math.abs(this.mDestination.mX - this.mPosition.mX);
        CThing_ShotFlameThrower.mcDraw.Process();
        CThing_ShotFlameThrower.mcDraw.mDirection = this.mOwner.mAngle;
        CCity._this.UpdateMCPosition(this.mOwner.GetWeaponPosition(),CThing_ShotFlameThrower.mcDraw);
        if(CThing_ShotFlameThrower.mcDraw.mCount == 0 && CThing_ShotFlameThrower.mcDraw.mActive == false)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CThing_ShotFlameThrower.mcDraw.Draw();
        CCity._RenderScratch = true;
    }
}
