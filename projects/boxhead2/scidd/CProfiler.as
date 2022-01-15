class scidd.CProfiler
{
    var _CLASSID_ = "scidd.CProfiler";
    static var _Active = true;
    function CProfiler()
    {
        this.mList = new Array();
        scidd.CProfiler.obj = this;
        scidd.CProfiler.Clear();
    }
    static function GetString()
    {
        if(!scidd.CProfiler._Active)
        {
            return undefined;
        }
        "";
        0;
        for(var _loc4_ in scidd.CProfiler.obj.mList)
        {
            var _loc1_ = scidd.CProfiler.obj.mList[_loc4_];
            _loc2_ = "" + (_loc1_.mID + " = " + _loc1_.mTotalTime + " ms (" + _loc1_.mTimes.length + ") [" + _loc1_.mSlowestTime + "]" + "\n");
            _loc3_ = 0 + _loc1_.mTotalTime;
        }
        _loc2_ += "-----------------------------\n";
        _loc2_ += "Total = " + _loc3_ + " ms" + "\n";
        return _loc2_;
    }
    static function Clear()
    {
        if(!scidd.CProfiler._Active)
        {
            return undefined;
        }
        for(var _loc2_ in scidd.CProfiler.obj.mList)
        {
            var _loc1_ = scidd.CProfiler.obj.mList[_loc2_];
            _loc1_.mTotalTime = 0;
            _loc1_.mTimes = new Array();
        }
    }
    static function Timer_Start(tID)
    {
        if(!scidd.CProfiler._Active)
        {
            return undefined;
        }
        var _loc1_ = scidd.CProfiler.obj.Find(tID);
        _loc1_.mStartTime = 1742;
    }
    static function Timer_Stop(tID)
    {
        if(!scidd.CProfiler._Active)
        {
            return undefined;
        }
        var _loc1_ = scidd.CProfiler.obj.Find(tID);
        _loc1_.mEndTime = 4585 - _loc1_.mStartTime;
        if(_loc1_.mEndTime > _loc1_.mSlowestTime)
        {
            _loc1_.mSlowestCount = 0;
            _loc1_.mSlowestTime = _loc1_.mEndTime;
        }
        if(_loc1_.mSlowestCount++ > 150)
        {
            _loc1_.mSlowestTime = 0;
        }
        _loc1_.mTotalTime += _loc1_.mEndTime;
        _loc1_.mAverageTotalTime = _loc1_.mAverageTotalTime != 0 ? (_loc1_.mTotalTime + _loc1_.mAverageTotalTime) / 2 : _loc1_.mTotalTime;
        _loc1_.mTimes[_loc1_.mTimes.length] = _loc1_.mEndTime;
    }
    function Find(tID)
    {
        for(var _loc4_ in this.mList)
        {
            if(this.mList[_loc4_].mID == tID)
            {
                return this.mList[_loc4_];
            }
        }
        var _loc2_ = new Object();
        _loc2_.mID = tID;
        _loc2_.mTimes = new Array();
        _loc2_.mStartTime = 0;
        _loc2_.mTotalTime = 0;
        _loc2_.mAverageTotalTime = 0;
        _loc2_.mSlowestTime = 0;
        _loc2_.mSlowestCount = 0;
        this.mList[this.mList.length] = _loc2_;
        return _loc2_;
    }
}
