class Thing.Effect.CThing_Effect extends Thing.CThing
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Effect";
    var _BASECLASSID_ = "CThing_Effect";
    function CThing_Effect(tPosition, tAngle, tParent)
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
