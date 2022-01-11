class Thing.Affect.CThing_Affect_DevilAttack extends Thing.Affect.CThing_Affect
{
    var _CLASSID_ = "CThing_Affect_DevilAttack";
    function CThing_Affect_DevilAttack(tOwner, tAffector, tDamage, tHitDirection)
    {
        super(Thing.Affect.CThing_Affect.mAffect_DevilAttack,tOwner,tAffector,tDamage);
        this.mHitDirection = tHitDirection;
    }
    function AffectThing(tThing)
    {
        tThing.mLife -= this.mDamage;
        return this.mDamage;
    }
}
