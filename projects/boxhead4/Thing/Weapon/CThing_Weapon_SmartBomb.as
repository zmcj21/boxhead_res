class Thing.Weapon.CThing_Weapon_SmartBomb extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_SmartBomb";
    var mNameID = "smartbomb";
    var mName = "Smart Bomb";
    function CThing_Weapon_SmartBomb(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 12;
        this.mAmmo = 20;
        this.mTotalAmmo = 20;
        this.mFireRateCount = 0;
        this.mDamage = 100;
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
        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_SmartBomb(this.mParent.mPosition,this.mParent.Angle,this.mParent,3));
        this.DecrementAmmo();
    }
}
