class CThing_Railgun extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Railgun";
    var _BASECLASSID_ = "CThing_Railgun";
    function CThing_Railgun(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(30);
        this.__set__mTotalAmmo(this.__set__mAmmo(50));
        this.mFireRateCount = 0;
        this.mDamage = 20;
        this.mShotPosIndex = 1;
        this.__set__mAuto(true);
        this.mName = "Railgun";
        this.mSound = CSound.mRailgun;
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_Railgun._Defaults;
        }
        else
        {
            CThing_Railgun._Defaults = CThing_Railgun._Defaults != undefined ? CThing_Railgun._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_Railgun._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_Railgun._Defaults.mRapidFire ? this._FireRate : 5;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_Railgun._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_Railgun._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_Railgun._Defaults.mRapidFire ? this._Auto : true;
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
        CThing.AddThing(new CThing_ShotRailgun(initPosition,dir.mZ,this.mID,this.mOwner,100));
        CThing.AddThing(new CThing_MuzzleFlash_Railgun(initPosition,dir.mZ,this.mID));
    }
}
