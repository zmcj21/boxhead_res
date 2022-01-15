class Thing.Affect.CThing_Affect
{
    var Dispose = 0;
    var _CLASSID_ = "CThing_Affect";
    var _BASECLASSID_ = "CThing_Affect";
    static var mAffect_None = 0;
    static var mAffect_Bullet = 1;
    static var mAffect_Electricuted = 2;
    static var mAffect_Explosion = 4;
    static var mAffect_Punched = 8;
    static var mAffect_Push = 16;
    static var mAffect_Vapourize = 32;
    static var mAffect_ZombieAttack = 64;
    static var mAffect_PlayerLineOfSight = 128;
    static var mAffect_DevilAttack = 256;
    function CThing_Affect(tType, tOwner, tAffector, tDamage)
    {
        this.mType = tType;
        this.mDamage = tDamage;
        this.mAffector = tAffector;
        this.mOwner = tOwner;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function AffectThing(tThing)
    {
        tThing.mLife -= this.mDamage;
        return this.mDamage;
    }
}
