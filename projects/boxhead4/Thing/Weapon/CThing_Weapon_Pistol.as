class Thing.Weapon.CThing_Weapon_Pistol extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Pistol";
    var mNameID = "pistol";
    var mName = "Pistol";
    var mShortName = "Pistol";
    function CThing_Weapon_Pistol(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 8;
        this.mTotalAmmo = this.mAmmo = Thing.Weapon.CThing_Weapon.mInfinateAmmo;
        this.mFireRateCount = 0;
        this.mDamage = 26;
        this.mAuto = false;
        this.mRange = 8;
        if(!Thing.Weapon.CThing_Weapon_Pistol.mcMuzzleFlash)
        {
            Thing.Weapon.CThing_Weapon_Pistol.mcMuzzleFlash = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional("Pistol.MuzzleFlash",8);
        }
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
        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_MuzzleFlash(tPosition.Clone(),tAngle,Thing.Weapon.CThing_Weapon_Pistol.mcMuzzleFlash));
        this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Bullet(tPosition,tAngle,this.mParent,this.mDamage,8));
        this.PlaySound(CSound.mSamples.Weapon_Pistol_Fire_wav);
    }
}
