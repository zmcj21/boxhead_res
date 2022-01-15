class CThing_UZI extends CThing_Weapon
{
    var _CLASSID_ = "CThing_UZI";
    var _BASECLASSID_ = "CThing_UZI";
    function CThing_UZI(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(4);
        this.__set__mTotalAmmo(this.__set__mAmmo(200));
        this.mFireRateCount = 0;
        this.mDamage = 40;
        this.__set__mAuto(true);
        this.mSound = CSound.mUZIShot;
        this.mName = "UZI";
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_UZI._Defaults;
        }
        else
        {
            CThing_UZI._Defaults = CThing_UZI._Defaults != undefined ? CThing_UZI._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_UZI._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_UZI._Defaults.mRapidFire ? this._FireRate : 2;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_UZI._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_UZI._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_UZI._Defaults.mRapidFire ? this._Auto : true;
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
