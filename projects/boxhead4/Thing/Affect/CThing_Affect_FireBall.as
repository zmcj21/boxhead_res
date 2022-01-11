class Thing.Affect.CThing_Affect_FireBall extends Thing.Affect.CThing_Affect
{
    var _CLASSID_ = "CThing_Affect_FireBall";
    function CThing_Affect_FireBall(tOwner, tAffector, tDamage, tHitDirection)
    {
        super(Thing.Affect.CThing_Affect.mAffect_FireBall,tOwner,tAffector,tDamage);
        this.mHitDirection = tHitDirection;
    }
    function AffectThing(tThing)
    {
        tThing.mLife -= this.mDamage;
        return this.mDamage;
    }
}
