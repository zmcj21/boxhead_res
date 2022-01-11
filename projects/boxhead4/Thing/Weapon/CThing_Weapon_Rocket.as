class Thing.Weapon.CThing_Weapon_Rocket extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Rocket";
    var mNameID = "rocket";
    var mName = "Rocket Launcher";
    var mShortName = "Rockets";
    function CThing_Weapon_Rocket(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 12;
        this.mAmmo = 20;
        this.mTotalAmmo = 20;
        this.mFireRateCount = 0;
        this.mDamage = 250;
        this.mAuto = false;
        tParent.mWorld.mUpgrades.Register_Weapon(this);
        this.Process = this.Process_Normal;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Fire(tPosition, tAngle)
    {
        super.Fire(tPosition,tAngle);
        var _loc4_ = tPosition.Clone();
        var _loc3_ = this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Rocket(_loc4_,tAngle,this.mParent,this.mDamage));
        _loc3_.mEffect = new Thing.Effect.CThing_Effect_Explosion(_loc4_,tAngle,this.mParent,this.mDamage);
        _loc3_.mEffect.mClusterExplode = this.mClusterExplode;
        _loc3_.mEffect.mBiggerBang = this.mBiggerBang;
        this.PlaySound(CSound.mSamples.Weapon_Rocket_Fire_wav);
    }
}
