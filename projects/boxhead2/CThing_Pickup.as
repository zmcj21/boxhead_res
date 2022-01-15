class CThing_Pickup extends CThing_Move
{
    var _CLASSID_ = "CThing_Pickup";
    var _BASECLASSID_ = "CThing_Pickup";
    function CThing_Pickup(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        this.mPickedUp = true;
        this.mPickedUpCounter = 0;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        if(!this.mPickedUp)
        {
            return undefined;
        }
        if(CThing_Player.mValidWeapons.length < 2)
        {
            return undefined;
        }
        if(--this.mPickedUpCounter < 0)
        {
            this.Move(CMapwho.CentrePosition(this.mPosition));
        }
    }
    function Pickup(byThing)
    {
        this.oMapwho.mMapwho.Remove(this.oMapwho);
        this.mPickedUpCounter = 900;
        this.mPickedUp = true;
    }
    static function CheckForPickup(tThing)
    {
        var _loc5_ = tThing.oMapwho.mMapwho.GetCellPosition(tThing.mPosition.mX,tThing.mPosition.mY);
        var _loc4_ = tThing.oMapwho.mMapwho.GetCell(_loc5_.x,_loc5_.y);
        var _loc1_ = _loc4_.mChild;
        while(_loc1_ != undefined)
        {
            var _loc2_ = _loc1_.mObject;
            if(_loc2_._BASECLASSID_ == "CThing_Pickup")
            {
                _loc2_.Pickup(tThing);
            }
            _loc1_ = _loc1_.mChild;
        }
    }
}
