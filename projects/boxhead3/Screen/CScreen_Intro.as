class Screen.CScreen_Intro extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_Intro";
    var mFrameCap = 10;
    function CScreen_Intro()
    {
        super();
        this.mSequence = new Array();
        if(this._Logo_SeanCooper != undefined)
        {
            this.mSequence.push(this._Logo_SeanCooper);
        }
        if(this._Logo_CrazyMonkeys != undefined)
        {
            this.mSequence.push(this._Logo_CrazyMonkeys);
        }
        for(var _loc3_ in this.mSequence)
        {
            this.mSequence[_loc3_].stop();
            this.mSequence[_loc3_]._visible = false;
        }
        this.mSequenceIndex = 0;
        this._parent.mSingleFrame = true;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
        if(this.__get__mNormal())
        {
            var _loc3_ = this.mSequence[this.mSequenceIndex];
            if(_loc3_._visible == false)
            {
                this.mTimeSlice = undefined;
                _loc3_._visible = true;
                _loc3_.gotoAndStop(1);
            }
            else if(_loc3_._currentframe == _loc3_._totalframes)
            {
                _loc3_._visible = false;
                this.mSequenceIndex++;
                if(this.mSequenceIndex >= this.mSequence.length)
                {
                    this.nState = "State_Main";
                    return undefined;
                }
            }
            else
            {
                _loc3_.gotoAndStop(this.GetFrameIndex(_loc3_._totalframes,_loc3_.mFrameRate));
            }
        }
    }
    function Draw()
    {
        super.Draw();
    }
    function GetFrameIndex(tTotalFrames, tFrameRate)
    {
        this.mTimeSlice = this.mTimeSlice != undefined ? this.mTimeSlice : getTimer();
        var _loc2_ = int((10570 - this.mTimeSlice) / (1000 / tFrameRate)) + 1;
        if(_loc2_ > tTotalFrames)
        {
            _loc2_ = tTotalFrames;
        }
        return _loc2_;
    }
}
