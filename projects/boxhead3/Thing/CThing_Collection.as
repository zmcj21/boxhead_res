class Thing.CThing_Collection
{
    var Dispose = 0;
    var _CLASSID_ = "CThing_Collection";
    var _BASECLASSID_ = "CThing_Collection";
    function CThing_Collection(tWorld)
    {
        this.mThings = new Array();
        this.mPlayerThings = new Array();
        this.mThingCounters = new Object();
        this.mWorld = tWorld;
        this.mTimeSlice_25 = 0;
        this.mTimeSlice_8 = 0;
        this.mTimeSlice_4 = 0;
        this.mThingCounters.INVALIDPOSITION = 0;
        Thing.CThing.Renew();
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
        1.7976931348623157e+308;
        var _loc4_ = undefined;
        if(this.mPlayerThings.length == 1)
        {
            return this.mPlayerThings[prop];
        }
        for(var _loc2_ in this.mPlayerThings)
        {
            if(_loc2_ < 1.7976931348623157e+308)
            {
                _loc3_ = _loc2_;
                _loc4_ = this.mPlayerThings[prop];
            }
        }
        return _loc4_;
    }
    function Process()
    {
        scidd.CProfiler.Timer_Start("Thing.Process");
        this.mTimeSlice_25 = (this.mTimeSlice_25 + 1) % 25;
        this.mTimeSlice_8 = this.mTimeSlice_8 + 1 & 7;
        this.mTimeSlice_4 = this.mTimeSlice_4 + 1 & 3;
        0;
        for(var _loc4_ in this.mDeleteThings)
        {
            this.mThings[_loc4_].Dispose();
            delete this.mThings[_loc4_];
            1;
        }
        this.mDeleteThings = new Array();
        0;
        for(_loc4_ in this.mThings)
        {
            this.mThings[_loc4_].Process();
            1;
        }
        scidd.CProfiler.SetVariable("Process",1);
        scidd.CProfiler.SetVariable("Delete",1);
        scidd.CProfiler.SetVariable("ZOMBIE",this.mThingCounters.CThing_Creature_Zombie);
        scidd.CProfiler.Timer_Stop("Thing.Process");
    }
    function Draw()
    {
        for(var _loc2_ in this.mThings)
        {
            this.mThings[_loc2_].Draw();
        }
    }
}
