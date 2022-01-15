class CThing_RocketLauncher extends CThing_Weapon
{
    var _CLASSID_ = "CThing_RocketLauncher";
    var _BASECLASSID_ = "CThing_RocketLauncher";
    function CThing_RocketLauncher(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 30;
        this.mAmmo = 5;
        this.mTotalAmmo = 5;
        this.mFireRateCount = 0;
        this.mDamage = 50;
        this.mShotPosIndex = 0;
        this.mAuto = false;
        this.mSound = CSound.mRocketLauncherShot;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
