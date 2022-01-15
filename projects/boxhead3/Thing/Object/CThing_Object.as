class Thing.Object.CThing_Object extends Thing.CThing
{
    var Process_Normal = 0;
    var Process_Sleep = 0;
    var _CLASSID_ = "CThing_Object";
    var _BASECLASSID_ = "CThing_Object";
    function CThing_Object(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.Process = this.Process_Normal;
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
