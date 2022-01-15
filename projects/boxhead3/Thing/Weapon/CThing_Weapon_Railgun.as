class Thing.Weapon.CThing_Weapon_Railgun extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Railgun";
    var mNameID = "railgun";
    var mName = "Railgun";
    function CThing_Weapon_Railgun(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 14;
        this.mAmmo = 15;
        this.mTotalAmmo = 15;
        this.mFireRateCount = 0;
        this.mDamage = 100;
        this.mAuto = false;
        this.mRange = 10;
        tParent.mWorld.mUpgrades.Register_Weapon(this);
        if(!Thing.Weapon.CThing_Weapon_Railgun.mcMuzzleFlash)
        {
            Thing.Weapon.CThing_Weapon_Railgun.mcMuzzleFlash = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional("Railgun.MuzzleFlash",8);
        }
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
        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_MuzzleFlash(tPosition.Clone(),tAngle,Thing.Weapon.CThing_Weapon_Railgun.mcMuzzleFlash));
        this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Railgun(tPosition,tAngle,this.mParent,this.mDamage,this.mRange));
        this.PlaySound(CSound.mSamples.Weapon_Railgun_Fire_wav);
    }
}
