class CThing_Pistol extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Pistol";
    var _BASECLASSID_ = "CThing_Pistol";
    function CThing_Pistol(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(6);
        this.__set__mTotalAmmo(this.__set__mAmmo(100000000));
        this.mFireRateCount = 0;
        this.mDamage = 25;
        this.mShotPosIndex = 0;
        this.__set__mAuto(false);
        this.mName = "Pistol";
        this.mSound = CSound.mPistolShot;
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_Pistol._Defaults;
        }
        else
        {
            CThing_Pistol._Defaults = CThing_Pistol._Defaults != undefined ? CThing_Pistol._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_Pistol._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_Pistol._Defaults.mRapidFire ? this._FireRate : 2;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_Pistol._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_Pistol._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_Pistol._Defaults.mRapidFire ? this._Auto : true;
    }
    function set mAuto(a)
    {
        this._Auto = a;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
