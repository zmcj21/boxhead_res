class Thing.Effect.CThing_Effect_BloodPool extends Thing.Effect.CThing_Effect
{
    var Process_Normal = 0;
    var _CLASSID_ = "CThing_Effect_BloodPool";
    function CThing_Effect_BloodPool(tPosition, tAngle, tParent)
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
