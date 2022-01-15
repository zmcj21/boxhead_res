class CThing_Move extends CThing
{
    var _CLASSID_ = "CThing_Move";
    var _BASECLASSID_ = "CThing_Move";
    function CThing_Move(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Move(nPosition)
    {
        this.mPosition.Set(nPosition);
        return this.oMapwho.mMapwho.Move(this.oMapwho,this.mPosition.mX,this.mPosition.mY);
    }
    function Dispose()
    {
        super.Dispose();
    }
}
