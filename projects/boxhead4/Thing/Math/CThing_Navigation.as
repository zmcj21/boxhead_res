class Thing.Math.CThing_Navigation
{
    var _CLASSID_ = "CThing_Navigation";
    var _BASECLASSID_ = "CThing_Navigation";
    function CThing_Navigation(tOwner)
    {
        this.mOwner = tOwner;
        this.mMap = this.mOwner.mWorld.mMap;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function MoveInDirection2(tDirection)
    {
        var _loc6_ = this.mMap.GetCell(this.mOwner.mPosition.mX,this.mOwner.mPosition.mY);
        if(_loc6_.CollideFlagsInDirection(tDirection) & World.Map.CMap_Cell.mCollide_NonMovable)
        {
            1;
            1;
            var _loc3_ = tDirection - 1;
            var _loc2_ = tDirection + 1;
            while(true)
            {
                if(!(_loc6_.CollideFlagsInDirection(_loc3_) & World.Map.CMap_Cell.mCollide_NonMovable))
                {
                    return _loc3_;
                }
                if(!(_loc6_.CollideFlagsInDirection(_loc2_) & World.Map.CMap_Cell.mCollide_NonMovable))
                {
                    return _loc2_;
                }
                2;
                1;
                _loc3_ -= 1;
                _loc2_ += 1;
            }
        }
        return tDirection;
    }
}
