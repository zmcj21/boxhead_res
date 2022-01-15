class CThing_ShotGun extends CThing_Weapon
{
    var _CLASSID_ = "CThing_ShotGun";
    var _BASECLASSID_ = "CThing_ShotGun";
    function CThing_ShotGun(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.mFireRate = 30;
        this.mAmmo = 24;
        this.mTotalAmmo = 24;
        this.mFireRateCount = 0;
        this.mDamage = 100;
        this.mShotPosIndex = 1;
        this.mAuto = false;
        this.mSound = CSound.mShotGunShot;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Fire(initPosition, dir)
    {
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ,this.mID,this.mOwner,this.mDamage));
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ - 0.04363323129985824,this.mID,this.mOwner,this.mDamage));
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ - 0.08726646259971647,this.mID,this.mOwner,this.mDamage));
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ + 0.04363323129985824,this.mID,this.mOwner,this.mDamage));
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ + 0.08726646259971647,this.mID,this.mOwner,this.mDamage));
    }
}
