class CThing_UZI extends CThing_Weapon
{
    var _CLASSID_ = "CThing_UZI";
    var _BASECLASSID_ = "CThing_UZI";
    function CThing_UZI(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 5;
        this.mAmmo = 100;
        this.mTotalAmmo = 100;
        this.mFireRateCount = 0;
        this.mDamage = 40;
        this.mAuto = true;
        this.mSound = CSound.mUZIShot;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
