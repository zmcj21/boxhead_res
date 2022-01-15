class CThing_Affect
{
    var _CLASSID_ = "CThing_Affect";
    var _BASECLASSID_ = "CThing_Affect";
    static var mType_Bullet = 1;
    static var mType_Explosion = 2;
    static var mType_Zombie = 3;
    static var mType_Fire = 4;
    function CThing_Affect(tType, tOwner, tAffector, tDamage)
    {
        this.mType = tType;
        this.mDamage = tDamage;
        this.mAffector = tAffector;
        this.mOwner = tOwner;
    }
    static function Bullet(tOwner, tAffector, tDamage)
    {
        var _loc1_ = new CThing_Affect(CThing_Affect.mType_Bullet,tOwner,tAffector,tDamage);
        return _loc1_;
    }
    static function Explosion(tOwner, tAffector, tDamage, tRange)
    {
        var _loc1_ = new CThing_Affect(CThing_Affect.mType_Explosion,tOwner,tAffector,tDamage);
        _loc1_.mRange = tRange;
        return _loc1_;
    }
    static function Zombie(tOwner, tAffector, tDamage)
    {
        var _loc1_ = new CThing_Affect(CThing_Affect.mType_Zombie,tOwner,tAffector,tDamage);
        return _loc1_;
    }
}
