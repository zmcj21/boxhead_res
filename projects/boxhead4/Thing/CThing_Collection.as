class Thing.CThing_Collection
{
    var Dispose = 0;
    var _CLASSID_ = "CThing_Collection";
    var _BASECLASSID_ = "CThing_Collection";
    function CThing_Collection(tWorld)
    {
        this.mThings = new Object();
        this.mPlayerThings = new Object();
        this.mRespawnPlayer = new Object();
        this.mThingCounters = new Object();
        this.mWorld = tWorld;
        this.mTimeSlice_25 = 0;
        this.mTimeSlice_8 = 0;
        this.mTimeSlice_4 = 0;
        this.mThingCounters.INVALIDPOSITION = 0;
        Thing.CThing.Renew();
        World.Map.CMap_Cell.Nav_Reset();
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function AddThing(tThing)
    {
        this.mThings[tThing.sUniqueID] = tThing;
        tThing.mThing_Collection = this;
        tThing.mWorld = this.mWorld;
        this.mThingCounters[tThing._CLASSID_] = this.mThingCounters[tThing._CLASSID_] != undefined ? this.mThingCounters[tThing._CLASSID_] + 1 : 1;
        return tThing;
    }
    function AddThing_Shot(tThing)
    {
        return this.AddThing(tThing);
    }
    function AddThing_Effect(tThing)
    {
        return this.AddThing(tThing);
    }
    function AddThing_Player(tPlayer)
    {
        this.AddThing(tPlayer);
        this.mPlayerThings[tPlayer.sUniqueID] = tPlayer;
        return tPlayer;
    }
    function Register_Thing(tThing)
    {
        tThing.mThing_Collection = this;
        tThing.mWorld = this.mWorld;
        return tThing;
    }
    function DeleteThing(tThing)
    {
        this.mThingCounters[tThing._CLASSID_]--;
        this.mDeleteThings[tThing.sUniqueID] = tThing;
    }
    function DeleteThing_Player(tPlayer)
    {
        this.DeleteThing(tPlayer);
        this.mPlayerThings[tPlayer.sUniqueID].Dispose();
        delete this.mPlayerThings[tPlayer.sUniqueID];
    }
    function SearchThings(sProp, sValue, tList)
    {
        var _loc3_ = new Array();
        tList = tList != undefined ? tList : this.mThings;
        for(var _loc4_ in tList)
        {
            if(tList[_loc4_][sProp] == sValue)
            {
                _loc3_.push(tList[_loc4_]);
            }
        }
        return _loc3_;
    }
    function GetThingByID(tID)
    {
        return this.mThings["t" + tID];
    }
    function GetClosestPlayer(p)
    {
        if(this.mThingCounters.CThing_Creature_Player == 1)
        {
            for(var _loc6_ in this.mPlayerThings)
            {
                return this.mPlayerThings[_loc6_];
                break;
            }
        }
        1.7976931348623157e+308;
        var _loc4_ = undefined;
        var _loc5_ = undefined;
        for(_loc6_ in this.mPlayerThings)
        {
            var _loc2_ = this.mPlayerThings[_loc6_];
            if(!(_loc2_.mFlags & Thing.CThing.mFlag_DEAD))
            {
                if((_loc4_ = p.Distance2D_SQR(_loc2_.mPosition)) < 1.7976931348623157e+308)
                {
                    _loc3_ = _loc4_;
                    _loc5_ = _loc2_;
                }
            }
        }
        if(!_loc5_)
        {
            for(_loc6_ in this.mPlayerThings)
            {
                return this.mPlayerThings[_loc6_];
                break;
            }
        }
        return _loc5_;
    }
    function GetOtherPlayer(tPlayer)
    {
        for(var _loc2_ in this.mPlayerThings)
        {
            if(tPlayer != this.mPlayerThings[_loc2_])
            {
                return this.mPlayerThings[_loc2_];
            }
        }
        return undefined;
    }
    function Process()
    {
        this.mTimeSlice_25 = (this.mTimeSlice_25 + 1) % 25;
        this.mTimeSlice_8 = this.mTimeSlice_8 + 1 & 7;
        this.mTimeSlice_4 = this.mTimeSlice_4 + 1 & 3;
        for(var _loc5_ in this.mDeleteThings)
        {
            this.mThings[_loc5_].Dispose();
            delete this.mThings[_loc5_];
        }
        this.mDeleteThings = new Object();
        for(_loc5_ in this.mThings)
        {
            this.mThings[_loc5_].Process();
        }
        World.Map.CMap_Cell.Nav_Restart();
        var _loc3_ = new Array();
        var _loc4_ = this.mWorld.mMap.mCells;
        for(_loc5_ in this.mPlayerThings)
        {
            var _loc2_ = this.mPlayerThings[_loc5_].mPosition;
            _loc3_.push(_loc4_[_loc2_.mY & 16777215][_loc2_.mX & 16777215]);
        }
        World.Map.CMap_Cell.Nav_Update(_loc3_);
    }
    function Draw()
    {
        for(var _loc2_ in this.mThings)
        {
            this.mThings[_loc2_].Draw();
        }
    }
}
