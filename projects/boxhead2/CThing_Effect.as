class CThing_Effect extends CThing_Move
{
    var _CLASSID_ = "CThing_Effect";
    var _BASECLASSID_ = "CThing_Effect";
    function CThing_Effect(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
