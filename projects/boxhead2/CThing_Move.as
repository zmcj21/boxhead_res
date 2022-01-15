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
        this.mPosition.mX = nPosition.mX;
        this.mPosition.mY = nPosition.mY;
        this.mPosition.mZ = nPosition.mZ;
        var _loc3_ = this.oMapwho.mCell.mID;
        var _loc2_ = CMapwho.mCellSizeShift;
        if(this.mPosition.mX >> _loc2_ == _loc3_.x && this.mPosition.mY >> _loc2_ == _loc3_.y)
        {
            return false;
        }
        return this.oMapwho.mMapwho.Move(this.oMapwho,this.mPosition.mX,this.mPosition.mY);
    }
    function Dispose()
    {
        super.Dispose();
    }
}
