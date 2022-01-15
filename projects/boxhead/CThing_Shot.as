class CThing_Shot extends CThing_Move
{
    var _CLASSID_ = "CThing_Shot";
    var _BASECLASSID_ = "CThing_Shot";
    function CThing_Shot(tPosition, tAngle, tID, tOwner, tDamage)
    {
        super(tPosition,tAngle,tID);
        this.mOwner = tOwner;
        this.mDamage = tDamage;
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
