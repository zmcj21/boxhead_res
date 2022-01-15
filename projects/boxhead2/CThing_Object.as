class CThing_Object extends CThing_Move
{
    var Process = 0;
    var _CLASSID_ = "CThing_Object";
    var _BASECLASSID_ = "CThing_Object";
    function CThing_Object(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
    }
    function toString()
    {
        return this._CLASSID_;
    }
}
