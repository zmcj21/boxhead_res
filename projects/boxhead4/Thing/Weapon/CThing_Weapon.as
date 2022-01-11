class Thing.Weapon.CThing_Weapon extends Thing.CThing
{
    var _CLASSID_ = "CThing_Weapon";
    var _BASECLASSID_ = "CThing_Weapon";
    static var mInfinateAmmo = 999999;
    var mNameID = "none";
    var mName = "NONE";
    function CThing_Weapon(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFireRateCount = 0;
        this.mFireRate = 10;
        this.mTotalAmmo = this.mAmmo = Thing.Weapon.CThing_Weapon.mInfinateAmmo;
    }
    static function byCLASSID(tCLASSID, tPosition, tAngle, tParent)
    {
        switch(tCLASSID)
        {
            case "CThing_Weapon_Pistol":
                return new Thing.Weapon.CThing_Weapon_Pistol(tPosition,tAngle,tParent);
            case "CThing_Weapon_UZI":
                return new Thing.Weapon.CThing_Weapon_UZI(tPosition,tAngle,tParent);
            case "CThing_Weapon_Shotgun":
                return new Thing.Weapon.CThing_Weapon_Shotgun(tPosition,tAngle,tParent);
            case "CThing_Weapon_Rocket":
                return new Thing.Weapon.CThing_Weapon_Rocket(tPosition,tAngle,tParent);
            case "CThing_Weapon_Grenade":
                return new Thing.Weapon.CThing_Weapon_Grenade(tPosition,tAngle,tParent);
            case "CThing_Weapon_Mine":
                return new Thing.Weapon.CThing_Weapon_Mine(tPosition,tAngle,tParent);
            case "CThing_Weapon_Barrel":
                return new Thing.Weapon.CThing_Weapon_Barrel(tPosition,tAngle,tParent);
            case "CThing_Weapon_Railgun":
                return new Thing.Weapon.CThing_Weapon_Railgun(tPosition,tAngle,tParent);
            case "CThing_Weapon_Devastator":
                return new Thing.Weapon.CThing_Weapon_Devastator(tPosition,tAngle,tParent);
            case "CThing_Weapon_SmartBomb":
                return new Thing.Weapon.CThing_Weapon_SmartBomb(tPosition,tAngle,tParent);
            case "CThing_Weapon_ChargePack":
                return new Thing.Weapon.CThing_Weapon_ChargePack(tPosition,tAngle,tParent);
            case "CThing_Weapon_FakeWall":
                return new Thing.Weapon.CThing_Weapon_FakeWall(tPosition,tAngle,tParent);
            default:
                return undefined;
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Reset()
    {
        this.mFireRateCount = 0;
    }
    function Update(tKey)
    {
        this.mWorld.mUpgrades.ApplyUpgrade_Weapon(this);
        if(this.WeaponEmpty())
        {
            this.mWorld.mHud.AddMessage_Critical(this.mName + " is out of ammo!");
            this.mParent.SelectWeapon("pistol");
            return undefined;
        }
        if(--this.mFireRateCount <= 0)
        {
            this.mFireRateCount = 0;
            if(this.mAuto)
            {
                if(this.mFire = tKey.IsDown())
                {
                    this.Fire(this.mParent.GetWeaponPosition(),this.mParent.mAngle.Clone(),tKey.mTimeDown);
                }
            }
            else if(this.mOnRelease)
            {
                if(this.mFire = tKey.IsReleased())
                {
                    this.Fire(this.mParent.GetWeaponPosition(),this.mParent.mAngle.Clone(),tKey.mTimePressed);
                }
            }
            else if(this.mFire = tKey.IsPressed())
            {
                this.Fire(this.mParent.GetWeaponPosition(),this.mParent.mAngle.Clone());
            }
        }
    }
    function WeaponEmpty()
    {
        return this.mAmmo <= 0;
    }
    function Fire(tPosition, tAngle)
    {
        this.DecrementAmmo();
    }
    function DecrementAmmo()
    {
        this.mAmmo -= this.mTotalAmmo != Thing.Weapon.CThing_Weapon.mInfinateAmmo ? 1 : 0;
        this.mFireRateCount = this.mFireRate;
    }
    function EmptyWeapon()
    {
        this.mAmmo = this.mTotalAmmo != Thing.Weapon.CThing_Weapon.mInfinateAmmo ? 0 : this.mTotalAmmo;
    }
}
