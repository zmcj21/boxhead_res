class CThing_Lightning extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Lightning";
    var _BASECLASSID_ = "CThing_Lightning";
    function CThing_Lightning(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(0);
        this.__set__mTotalAmmo(this.__set__mAmmo(10000));
        this.mFireRateCount = 0;
        this.mDamage = 40;
        this.__set__mAuto(false);
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_Lightning._Defaults;
        }
        else
        {
            CThing_Lightning._Defaults = CThing_Lightning._Defaults != undefined ? CThing_Lightning._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_Lightning._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_Lightning._Defaults.mRapidFire ? this._FireRate : 2;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_Lightning._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_Lightning._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_Lightning._Defaults.mRapidFire ? this._Auto : true;
    }
    function set mAuto(a)
    {
        this._Auto = a;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Fire(initPosition, dir)
    {
        this.mShot = CThing.AddThing(new CThing_ShotLightning(initPosition,dir.mZ,this.mID,this.mOwner));
    }
    function Process()
    {
        super.Process();
    }
    function StopFire()
    {
        this.mShot.mDelete = true;
    }
}
