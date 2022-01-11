class Thing.Weapon.CThing_Weapon_Grenade extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Grenade";
    var mNameID = "grenade";
    var mName = "Grenades";
    var mShortName = "Grenades";
    function CThing_Weapon_Grenade(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 12;
        this.mAmmo = 20;
        this.mTotalAmmo = 20;
        this.mFireRateCount = 0;
        this.mDamage = 150;
        this.mAuto = false;
        this.mOnRelease = true;
        this.mRange = 6;
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
    function Fire(tPosition, tAngle, tTime)
    {
        var _loc3_ = tPosition.Clone();
        var _loc4_ = (1939 - tTime) / 1000;
        var _loc2_ = this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Grenade(_loc3_,tAngle,this.mParent,this.mDamage,scidd.Math.CMath.Range(_loc4_,0.25,0.75)));
        _loc2_.mEffect = new Thing.Effect.CThing_Effect_Explosion(_loc3_,tAngle,this.mParent,this.mDamage);
        _loc2_.mEffect.mClusterExplode = this.mClusterExplode;
        _loc2_.mEffect.mBiggerBang = this.mBiggerBang;
        this.DecrementAmmo();
    }
}
