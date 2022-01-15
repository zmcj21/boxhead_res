class CThing_Static extends CThing
{
    var _CLASSID_ = "CThing_Static";
    var _BASECLASSID_ = "CThing_Static";
    function CThing_Static(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
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
