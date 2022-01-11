class Thing.Weapon.CThing_Weapon_Barrel extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_Barrel";
    var mNameID = "barrel";
    var mName = "Barrels";
    var mShortName = "Barrels";
    function CThing_Weapon_Barrel(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 1;
        this.mAmmo = 10;
        this.mTotalAmmo = 10;
        this.mFireRateCount = 0;
        this.mDamage = 150;
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
        var _loc2_ = tPosition.Clone();
        var _loc3_ = this.mWorld.mMap.GetCell(_loc2_.mX,_loc2_.mY);
        if(_loc3_.mChildCount <= 1)
        {
            this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Barrel(_loc2_,tAngle,this.mParent,this.mDamage));
            this.DecrementAmmo();
            this.PlaySound(CSound.mSamples.Object_Barrel_Place_wav);
        }
    }
}
