class CThing_Grenade extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Grenade";
    var _BASECLASSID_ = "CThing_Grenade";
    function CThing_Grenade(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 30;
        this.mAmmo = 15;
        this.mTotalAmmo = 15;
        this.mFireRateCount = 0;
        this.mDamage = 50;
        this.mShotPosIndex = 1;
        this.mAuto = false;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Fire(initPosition, dir)
    {
        CThing.AddThing(new CThing_ShotGrenade(initPosition,dir.mZ,this.mID,this.mOwner,1));
    }
}
