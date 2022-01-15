class CThing_FlameThrower extends CThing_Weapon
{
    var _CLASSID_ = "CThing_FlameThrower";
    var _BASECLASSID_ = "CThing_FlameThrower";
    function CThing_FlameThrower(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 30;
        this.mAmmo = 200;
        this.mFireRateCount = 0;
        this.mDamage = 20;
        this.mShotPosIndex = 1;
        this.mAuto = true;
        this.mSound = CSound.mFlameThrowerShot;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
