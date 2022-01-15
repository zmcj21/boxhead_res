class External.CTracker
{
    var _CLASSID_ = "CTracker";
    var _BASECLASSID_ = "CTracker";
    static var mURL = "http://data.seantcooper.com/boxhead_morerooms/Counters";
    function CTracker()
    {
        trace("new CTracker()");
    }
    static function Click(cbParent, cbFunction, tActionType, tActionCount)
    {
        var _loc1_ = new External.CTracker();
        _loc1_._Click(cbParent,cbFunction,tActionType,tActionCount);
    }
    function _Click(cbParent, cbFunction, tActionType, tActionCount)
    {
        if(_global.mAllowLocalHost == false && new LocalConnection().domain() == "localhost")
        {
            return undefined;
        }
        trace("********** SEND CLICK " + tActionType);
        this.mReceivedData = new LoadVars();
        this.mReceivedData.cbFunction = cbFunction;
        this.mReceivedData.cbParent = cbParent;
        this.mReceivedData.mActionType = tActionType;
        this.mReceivedData.onLoad = function(success)
        {
            "";
            _loc3_ = "" + ("-----Data Received (" + this.mActionType + ")" + "\n");
            _loc3_ += "-----success = " + success + "\n";
            _loc3_ += "-----this.mReturn = " + this.mReturn + "\n";
            _loc3_ += "-----this.mError = " + this.mError + "\n";
            trace(_loc3_);
            _root._ASP.text = _loc3_;
            this.cbParent[this.cbFunction](success,this.mReturn,this.mError);
        };
        this.mSendData = new LoadVars();
        this.mSendData.mDomain = new LocalConnection().domain();
        this.mSendData.mActionType = tActionType;
        this.mSendData.mActionCount = tActionCount;
        this.mSendData.mKey = this.GenerateKey("56799998877722985679999887772298",this.mSendData.mDomain);
        this.mSendData.sendAndLoad(External.CTracker.mURL + "/Click.asp",this.mReceivedData,"POST");
    }
    static function Click_CrazyMonkeyGames(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"CrazyMonkeyGames",1);
    }
    static function Click_SeanTCooper(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"SeanTCooper",1);
    }
    static function Click_SubmitHighscore(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"SubmitHighscore",1);
    }
    static function Click_ViewHighscore(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"ViewHighscore",1);
    }
    static function Click_Play(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Play1",1);
    }
    static function Click_Other1(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Other1",1);
    }
    static function Click_Other2(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Other2",1);
    }
    static function Click_PlayCount(tAmount, cbParent, cbFunction)
    {
        trace("Click_PlayCount Amount = " + tAmount);
        switch(tAmount)
        {
            case 5:
                return External.CTracker.Click(cbParent,cbFunction,"Play5",1);
            case 10:
                return External.CTracker.Click(cbParent,cbFunction,"Play10",1);
            case 25:
                return External.CTracker.Click(cbParent,cbFunction,"Play25",1);
            case 50:
                return External.CTracker.Click(cbParent,cbFunction,"Play50",1);
            case 100:
                return External.CTracker.Click(cbParent,cbFunction,"Play100",1);
            case 250:
                return External.CTracker.Click(cbParent,cbFunction,"Play250",1);
            case 500:
                return External.CTracker.Click(cbParent,cbFunction,"Play500",1);
            case 1000:
                return External.CTracker.Click(cbParent,cbFunction,"Play1000",1);
            default:
                return External.CTracker.Click(cbParent,cbFunction,"Play1",1);
        }
    }
    static function GetDomains(cbParent, cbFunction)
    {
        var _loc1_ = new External.CTracker();
        _loc1_._GetDomains(cbParent,cbFunction);
    }
    function _GetDomains(cbParent, cbFunction)
    {
        this.mReceivedData = new LoadVars();
        this.mReceivedData.cbFunction = cbFunction;
        this.mReceivedData.cbParent = cbParent;
        this.mReceivedData.onLoad = function(success)
        {
            this.cbParent[this.cbFunction](success,this.mReturn,this.mError);
        };
        this.mSendData = new LoadVars();
        this.mSendData.sendAndLoad(External.CTracker.mURL + "/GetDomains.asp",this.mReceivedData,"POST");
    }
    static function GetDomainInfo(cbParent, cbFunction, tDomain)
    {
        var _loc1_ = new External.CTracker();
        _loc1_._GetDomainInfo(cbParent,cbFunction,tDomain);
    }
    function _GetDomainInfo(cbParent, cbFunction, tDomain)
    {
        this.mReceivedData = new LoadVars();
        this.mReceivedData.cbFunction = cbFunction;
        this.mReceivedData.cbParent = cbParent;
        this.mReceivedData.onLoad = function(success)
        {
            this.cbParent[this.cbFunction](this.mActionType,success,this.mReturn,this.mError);
        };
        this.mSendData = new LoadVars();
        this.mSendData.mDomain = tDomain;
        this.mSendData.sendAndLoad(External.CTracker.mURL + "/GetDomainInfo.asp",this.mReceivedData,"POST");
    }
    function GenerateKey(inKey, eString)
    {
        "";
        0;
        while(0 < inKey.length)
        {
            _loc2_ = "" + (random(Number(inKey.substr(0,1))) + 1).toString();
            1;
        }
        trace("1. OutKey = " + _loc2_);
        "";
        0;
        while(0 < _loc2_.length)
        {
            var _loc3_ = (eString.charCodeAt(0 % eString.length) + Number(_loc2_.substr(0,1))) % 10;
            _loc6_ = "" + _loc3_.toString();
            1;
        }
        trace("2. eOutKey = " + _loc6_ + ", eString = " + eString);
        return _loc6_;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        delete this.mReceivedData;
        delete this.mSendData;
    }
}
