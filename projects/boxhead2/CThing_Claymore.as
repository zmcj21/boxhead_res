class CThing_Claymore extends CThing_Weapon
{
    var _CLASSID_ = "CThing_Claymore";
    var _BASECLASSID_ = "CThing_Claymore";
    function CThing_Claymore(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner);
        this.__set__mFireRate(5);
        this.__set__mTotalAmmo(this.__set__mAmmo(5));
        this.mFireRateCount = 0;
        this.mDamage = 40;
        this.__set__mAuto(false);
        this.mSound = CSound.mMinePlace;
        this.mName = "Mines";
    }
    static function UpdateDefaults(uObject)
    {
        if(uObject == undefined)
        {
            delete CThing_Claymore._Defaults;
        }
        else
        {
            CThing_Claymore._Defaults = CThing_Claymore._Defaults != undefined ? CThing_Claymore._Defaults : new Object();
            for(var _loc2_ in uObject)
            {
                CThing_Claymore._Defaults[_loc2_] = uObject[_loc2_];
            }
        }
    }
    function get mFireRate()
    {
        return !CThing_Claymore._Defaults.mRapidFire ? this._FireRate : 2;
    }
    function set mFireRate(a)
    {
        this._FireRate = a;
    }
    function get mAmmo()
    {
        return !CThing_Claymore._Defaults.mUnlimited ? this._Ammo : 100000000;
    }
    function set mAmmo(a)
    {
        this._Ammo = a;
    }
    function get mTotalAmmo()
    {
        return !CThing_Claymore._Defaults.mTotalAmmo ? this._TotalAmmo : 100000000;
    }
    function set mTotalAmmo(a)
    {
        this._TotalAmmo = a;
    }
    function get mAuto()
    {
        return !CThing_Claymore._Defaults.mRapidFire ? this._Auto : true;
    }
    function set mAuto(a)
    {
        this._Auto = a;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function CanFire(wp)
    {
        if(this.__get__mAmmo() > 0 || this.__get__mAmmo() == undefined)
        {
            var _loc2_ = CCity._this.mMapwho.CellChildCount(wp);
            if(_loc2_ <= 1)
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
        }
        return false;
    }
    function Fire(initPosition, dir)
    {
        var _loc1_ = CMapwho.CentrePosition(initPosition);
        _loc1_.mZ = 0;
        CThing.AddThing(new CThing_Object_Mine(_loc1_,0,undefined,CThing_Claymore._Defaults.mBigBang));
    }
}
