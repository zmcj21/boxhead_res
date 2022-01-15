class CThing_ShotGun extends CThing_Weapon
{
    var _CLASSID_ = "CThing_ShotGun";
    var _BASECLASSID_ = "CThing_ShotGun";
    function CThing_ShotGun(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(15);
        this.__set__mTotalAmmo(this.__set__mAmmo(40));
        this.mFireRateCount = 0;
        this.mDamage = 100;
        this.mShotPosIndex = 1;
        this.__set__mAuto(false);
        this.mSound = CSound.mShotGunShot;
        this.mName = "Shotgun";
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_ShotGun._Defaults;
        }
        else
        {
            CThing_ShotGun._Defaults = CThing_ShotGun._Defaults != undefined ? CThing_ShotGun._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_ShotGun._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_ShotGun._Defaults.mRapidFire ? this._FireRate : 5;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_ShotGun._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_ShotGun._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_ShotGun._Defaults.mRapidFire ? this._Auto : true;
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
        8;
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ,this.mID,this.mOwner,this.mDamage,8));
        if(CThing_ShotGun._Defaults.mBig)
        {
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ - 0.04363323129985824,this.mID,this.mOwner,this.mDamage,8));
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ + 0.04363323129985824,this.mID,this.mOwner,this.mDamage,8));
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ - 0.08726646259971647,this.mID,this.mOwner,this.mDamage,8));
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ + 0.08726646259971647,this.mID,this.mOwner,this.mDamage,8));
        }
        else
        {
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ - 0.02617993877991494,this.mID,this.mOwner,this.mDamage,8));
            CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ + 0.02617993877991494,this.mID,this.mOwner,this.mDamage,8));
        }
        CThing.AddThing(new CThing_MuzzleFlash(initPosition,dir.mZ,this.mID));
    }
}
