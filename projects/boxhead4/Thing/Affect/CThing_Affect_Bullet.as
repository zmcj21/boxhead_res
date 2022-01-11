class Thing.Affect.CThing_Affect_Bullet extends Thing.Affect.CThing_Affect
{
    var _CLASSID_ = "CThing_Affect_Bullet";
    function CThing_Affect_Bullet(tOwner, tAffector, tDamage, tHitDirection)
    {
        super(Thing.Affect.CThing_Affect.mAffect_Bullet,tOwner,tAffector,tDamage);
        this.mHitDirection = tHitDirection;
    }
    function AffectThing(tThing)
    {
        tThing.mLife -= this.mDamage;
        return this.mDamage;
    }
}
