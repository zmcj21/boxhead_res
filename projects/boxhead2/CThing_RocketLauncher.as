class CThing_RocketLauncher extends CThing_Weapon
{
    var _CLASSID_ = "CThing_RocketLauncher";
    var _BASECLASSID_ = "CThing_RocketLauncher";
    function CThing_RocketLauncher(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(30);
        this.__set__mTotalAmmo(this.__set__mAmmo(30));
        this.mFireRateCount = 0;
        this.mDamage = 50;
        this.mShotPosIndex = 0;
        this.__set__mAuto(false);
        this.mName = "Rocket Launcher";
        this.mSound = CSound.mMissile;
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_RocketLauncher._Defaults;
        }
        else
        {
            CThing_RocketLauncher._Defaults = CThing_RocketLauncher._Defaults != undefined ? CThing_RocketLauncher._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_RocketLauncher._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_RocketLauncher._Defaults.mRapidFire ? this._FireRate : 5;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_RocketLauncher._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_RocketLauncher._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_RocketLauncher._Defaults.mRapidFire ? this._Auto : true;
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
        CThing.AddThing(new CThing_Missile(initPosition,dir.mZ,this.mID,this.mOwner,CThing_RocketLauncher._Defaults.mBigBang));
    }
}
