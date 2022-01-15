class CThing_Weapon extends CThing_Static
{
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
        if(this.mFireRateCount < this.mFireRate)
        {
            this.mFireRateCount++;
        }
    }
    function CanFire()
    {
        if(this.mAmmo > 0 || this.mAmmo == undefined)
        {
            if(this.mFireRateCount >= this.mFireRate)
            {
                if(this.mAmmo != undefined && this.mAmmo != 10000)
                {
                    this.mAmmo--;
                }
                CHud.UpdateAmmo(this.mAmmo,this.mTotalAmmo);
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
    }
}
