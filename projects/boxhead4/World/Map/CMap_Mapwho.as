class World.Map.CMap_Mapwho
{
    var Dispose = 0;
    var _CLASSID_ = "CMap_Mapwho";
    var _BASECLASSID_ = "CMap_Mapwho";
    function CMap_Mapwho(tMap)
    {
        this.mMap = tMap;
        this.mMap_Cells = this.mMap.mCells;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function MoveThing(tThing)
    {
        var _loc2_ = tThing.mCellID;
        var _loc5_ = tThing.mPosition.mX & 16777215;
        var _loc4_ = tThing.mPosition.mY & 16777215;
        if(_loc5_ == _loc2_.x && _loc4_ == _loc2_.y)
        {
            return false;
        }
        if(_loc2_)
        {
            this.mMap_Cells[_loc2_.y][_loc2_.x].DeleteThing(tThing);
        }
        var _loc6_ = this.mMap_Cells[_loc4_][_loc5_];
        _loc6_.AddThing(tThing);
        tThing.mCellID = _loc6_.mID.clone();
        return true;
    }
    function AddThing(tThing)
    {
        var _loc3_ = this.mMap_Cells[tThing.mPosition.mY & 16777215][tThing.mPosition.mX & 16777215];
        _loc3_.AddThing(tThing);
        tThing.mCellID = _loc3_.mID.clone();
    }
    function DeleteThing(tThing)
    {
        if(tThing.mCellID)
        {
            this.mMap_Cells[tThing.mCellID.y][tThing.mCellID.x].DeleteThing(tThing);
            tThing.mCellID = undefined;
        }
    }
}
