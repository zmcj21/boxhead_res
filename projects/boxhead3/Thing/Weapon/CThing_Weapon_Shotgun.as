class Thing.Weapon.CThing_Weapon_Shotgun extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Shotgun";
    var mNameID = "shotgun";
    var mName = "Shotgun";
    function CThing_Weapon_Shotgun(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 12;
        this.mAmmo = 20;
        this.mTotalAmmo = 20;
        this.mFireRateCount = 0;
        this.mDamage = 51;
        this.mAuto = false;
        this.mRange = 7;
        this.mWideShot = 0;
        tParent.mWorld.mUpgrades.Register_Weapon(this);
        if(!Thing.Weapon.CThing_Weapon_Shotgun.mcMuzzleFlash)
        {
            Thing.Weapon.CThing_Weapon_Shotgun.mcMuzzleFlash = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional("Shotgun.MuzzleFlash",8);
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
        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_MuzzleFlash(tPosition.Clone(),tAngle,Thing.Weapon.CThing_Weapon_Shotgun.mcMuzzleFlash));
        this.PlaySound(CSound.mSamples.Weapon_Shotgun_Fire_wav);
        var _loc6_ = this.mRange;
        var _loc8_ = this.mParent;
        this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Bullet(tPosition.Clone(),tAngle,_loc8_,this.mDamage,_loc6_));
        0;
        2.5;
        2.5;
        while(0 <= this.mWideShot)
        {
            this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Bullet(tPosition.Clone(),new Thing.Math.CThing_Angle(tAngle.__get__mAngle() - 0.04363323129985824),_loc8_,this.mDamage,_loc6_,false));
            this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_Bullet(tPosition.Clone(),new Thing.Math.CThing_Angle(tAngle.__get__mAngle() + 0.04363323129985824),_loc8_,this.mDamage,_loc6_,false));
            1;
            0;
            _loc4_ = 2.5 + 2.5;
        }
    }
}
