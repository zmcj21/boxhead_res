class CThing_Grenade extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Grenade";
    var _BASECLASSID_ = "CThing_Grenade";
    function CThing_Grenade(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(10);
        this.__set__mTotalAmmo(this.__set__mAmmo(30));
        this.mFireRateCount = 0;
        this.mDamage = 50;
        this.mShotPosIndex = 1;
        this.__set__mAuto(false);
        this.mName = "Grenades";
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_Grenade._Defaults;
        }
        else
        {
            CThing_Grenade._Defaults = CThing_Grenade._Defaults != undefined ? CThing_Grenade._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_Grenade._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_Grenade._Defaults.mRapidFire ? this._FireRate : 2;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_Grenade._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_Grenade._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_Grenade._Defaults.mRapidFire ? this._Auto : true;
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
        CThing.AddThing(new CThing_ShotGrenade(initPosition,dir.mZ,this.mID,this.mOwner,1,CThing_Grenade._Defaults.mBigBang));
    }
}
