class Thing.Weapon.CThing_Weapon_UZI extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_UZI";
    var mNameID = "uzi";
    var mName = "UZI";
    var mShortName = "UZI";
    function CThing_Weapon_UZI(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 4;
        this.mAmmo = 100;
        this.mTotalAmmo = 100;
        this.mFireRateCount = 0;
        this.mDamage = 35;
        this.mAuto = true;
        this.mRange = 8;
        tParent.mWorld.mUpgrades.Register_Weapon(this);
        if(!Thing.Weapon.CThing_Weapon_UZI.mcMuzzleFlash)
        {
            Thing.Weapon.CThing_Weapon_UZI.mcMuzzleFlash = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional("UZI.MuzzleFlash",8);
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
        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_MuzzleFlash(tPosition.Clone(),tAngle,Thing.Weapon.CThing_Weapon_UZI.mcMuzzleFlash));
        this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Bullet(tPosition,tAngle,this.mParent,this.mDamage,this.mRange));
        this.PlaySound(CSound.mSamples.Weapon_UZI_Fire_wav);
    }
}
