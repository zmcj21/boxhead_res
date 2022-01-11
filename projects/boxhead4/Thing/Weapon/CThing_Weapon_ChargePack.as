class Thing.Weapon.CThing_Weapon_ChargePack extends Thing.Weapon.CThing_Weapon
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Weapon_ChargePack";
    var mNameID = "chargepack";
    var mName = "Charge Packs";
    var mShortName = "Charges";
    function CThing_Weapon_ChargePack(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRate = 1;
        this.mAmmo = 10;
        this.mTotalAmmo = 10;
        this.mFireRateCount = 0;
        this.mDamage = 150;
        this.mAuto = false;
        tParent.mWorld.mUpgrades.Register_Weapon(this);
        this.Reset();
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
        if(this.mDetonate)
        {
            var _loc2_ = this.mThing_Collection.SearchThings("mParent",this.mParent,this.mThing_Collection.SearchThings("_CLASSID_","CThing_Object_ChargePack"));
            for(var _loc3_ in _loc2_)
            {
                _loc2_[_loc3_].mDetonate = true;
            }
            this.mDetonate = false;
        }
        else
        {
            this.PlaySound(CSound.mSamples.Weapon_Mine_Place_wav);
            var _loc4_ = tPosition.Clone();
            var _loc5_ = this.mWorld.mMap.GetCell(_loc4_.mX,_loc4_.mY);
            if(_loc5_.mChildCount <= 1)
            {
                this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_ChargePack(_loc4_,tAngle,this.mParent,this.mDamage));
                this.mDetonate = true;
                this.DecrementAmmo();
            }
        }
    }
    function WeaponEmpty()
    {
        var _loc2_ = this.mThing_Collection.SearchThings("mParent",this.mParent,this.mThing_Collection.SearchThings("_CLASSID_","CThing_Object_ChargePack"));
        return _loc2_.length == 0 && this.mAmmo <= 0;
    }
    function Reset()
    {
        super.Reset();
        var _loc3_ = this.mThing_Collection.SearchThings("mParent",this.mParent,this.mThing_Collection.SearchThings("_CLASSID_","CThing_Object_ChargePack"));
        this.mDetonate = _loc3_.length && this.mAmmo <= 0;
    }
}
