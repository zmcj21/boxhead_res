class Thing.Affect.CThing_Affect_ZombieAttack extends Thing.Affect.CThing_Affect
{
    var _CLASSID_ = "CThing_Affect_ZombieAttack";
    function CThing_Affect_ZombieAttack(tOwner, tDamage)
    {
        super(Thing.Affect.CThing_Affect.mAffect_ZombieAttack,tOwner,tOwner,tDamage);
    }
    function AffectThing(tThing)
    {
        tThing.mLife -= this.mDamage;
        return this.mDamage;
    }
}
