if(!_global.External)
{
    _global.External = new Object();
}
§§pop();
if(!_global.External.CTracker)
{
    External.CTracker = 0;
    var _loc2_ = 0.prototype;
    0.Click = function(cbParent, cbFunction, tActionType, tActionCount)
    {
        return undefined;
    };
    _loc2_._Click = function(cbParent, cbFunction, tActionType, tActionCount)
    {
        if(_global.mAllowLocalHost == false && new LocalConnection().domain() == "localhost")
        {
            return undefined;
        }
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
            _root._ASP.text = _loc3_;
            this.cbParent[this.cbFunction](success,this.mReturn,this.mError);
        };
        this.mSendData = new LoadVars();
        this.mSendData.mDomain = new LocalConnection().domain();
        this.mSendData.mActionType = tActionType;
        this.mSendData.mActionCount = tActionCount;
        this.mSendData.mKey = this.GenerateKey("56799998877722985679999887772298",this.mSendData.mDomain);
        this.mSendData.sendAndLoad(External.CTracker.mURL + "/Click.asp",this.mReceivedData,"POST");
    };
    0.Click_CrazyMonkeyGames = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"CrazyMonkeyGames",1);
    };
    0.Click_SeanTCooper = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"SeanTCooper",1);
    };
    0.Click_SubmitHighscore = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"SubmitHighscore",1);
    };
    0.Click_ViewHighscore = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"ViewHighscore",1);
    };
    0.Click_Play = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Play1",1);
    };
    0.Click_Other1 = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Other1",1);
    };
    0.Click_Other2 = function(cbParent, cbFunction)
    {
        return External.CTracker.Click(cbParent,cbFunction,"Other2",1);
    };
    0.Click_PlayCount = function(tAmount, cbParent, cbFunction)
    {
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
    };
    0.GetDomains = function(cbParent, cbFunction)
    {
        var _loc1_ = new External.CTracker();
        _loc1_._GetDomains(cbParent,cbFunction);
    };
    _loc2_._GetDomains = function(cbParent, cbFunction)
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
    };
    0.GetDomainInfo = function(cbParent, cbFunction, tDomain)
    {
        var _loc1_ = new External.CTracker();
        _loc1_._GetDomainInfo(cbParent,cbFunction,tDomain);
    };
    _loc2_._GetDomainInfo = function(cbParent, cbFunction, tDomain)
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
    };
    _loc2_.GenerateKey = function(inKey, eString)
    {
        "";
        0;
        while(0 < inKey.length)
        {
            _loc2_ = "" + (random(Number(inKey.substr(0,1))) + 1).toString();
            1;
        }
        "";
        0;
        while(0 < _loc2_.length)
        {
            var _loc3_ = (eString.charCodeAt(0 % eString.length) + Number(_loc2_.substr(0,1))) % 10;
            _loc6_ = "" + _loc3_.toString();
            1;
        }
        return _loc6_;
    };
    _loc2_.toString = function()
    {
        return this._CLASSID_;
    };
    _loc2_.Dispose = function()
    {
        delete this.mReceivedData;
        delete this.mSendData;
    };
    _loc2_._CLASSID_ = "CTracker";
    _loc2_._BASECLASSID_ = "CTracker";
    0.mURL = "http://data.seantcooper.com/boxhead_morerooms/Counters";
    §§push(ASSetPropFlags(External.CTracker.prototype,null,1));
}
§§pop();
