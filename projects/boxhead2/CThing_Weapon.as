class CThing_Weapon extends CThing_Static
{
    var StopFire = 0;
    var _CLASSID_ = "CThing_Weapon";
    var _BASECLASSID_ = "CThing_Weapon";
    function CThing_Weapon(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID);
        this.mOwner = tOwner;
        this.mShotPosIndex = 0;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        if(this.mFireRateCount < this.__get__mFireRate())
        {
            this.mFireRateCount++;
        }
    }
    function get mFireRate()
    {
        return this._FireRate;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return this._Ammo;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return this._TotalAmmo;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return this._Auto;
    }
    function set mAuto(a)
    {
        this._Auto = a;
    }
    function CanFire()
    {
        if(this.__get__mAmmo() > 0 || this.__get__mAmmo() == undefined)
        {
            if(this.mFireRateCount >= this.__get__mFireRate())
            {
                if(this.__get__mAmmo() != undefined && this.__get__mAmmo() != 100000000)
                {
                    this.__set__mAmmo(this.__get__mAmmo() - 1);
                }
                CHud.UpdateAmmo(this.__get__mAmmo(),this.__get__mTotalAmmo());
                this.mFireRateCount = 0;
                if(this.mSound != undefined)
                {
                    this.PlaySound(this.mSound,this.mOwner.mPosition);
                }
                return true;
            }
        }
        return false;
    }
    function Fire(initPosition, dir)
    {
        CThing.AddThing(new CThing_Bullet(initPosition,dir.mZ,this.mID,this.mOwner,this.mDamage));
        CThing.AddThing(new CThing_MuzzleFlash(initPosition,dir.mZ,this.mID));
    }
}
