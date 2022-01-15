class CThing_Pistol extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Pistol";
    var _BASECLASSID_ = "CThing_Pistol";
    function CThing_Pistol(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 6;
        this.mAmmo = 10000;
        this.mTotalAmmo = 10000;
        this.mFireRateCount = 0;
        this.mDamage = 25;
        this.mShotPosIndex = 0;
        this.mAuto = false;
        this.mSound = CSound.mPistolShot;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
