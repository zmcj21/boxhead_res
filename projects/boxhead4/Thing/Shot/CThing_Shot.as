class Thing.Shot.CThing_Shot extends Thing.CThing
{
    var _CLASSID_ = "CThing_Shot";
    var _BASECLASSID_ = "CThing_Shot";
    function CThing_Shot(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition,tAngle,tParent);
        this.mDamage = tDamage;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
}
