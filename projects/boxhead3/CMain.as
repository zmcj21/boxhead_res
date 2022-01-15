class CMain extends MovieClip
{
    var Dispose = 0;
    var Draw = 0;
    var State_Instructions = 0;
    var State_InitWorld = 0;
    var _CLASSID_ = "CMain";
    var _BASECLASSID_ = "CMain";
    static var mFPS = 25;
    var mSingleFrame = false;
    var mFrameCap = 1;
    function CMain()
    {
        super();
        CMain._this = this;
        CMain.mSaveData = new CSaveData();
        CMain.mProfiler = new scidd.CProfiler();
        this.mScreenSize = new flash.geom.Point(this._Size._width,this._Size._height);
        CMain.mSound = new CSound(this);
        CMain.mInput = new CInput();
        this.mScreen_Collection = new Screen.CScreen_Collection(this,this.mScreenSize);
        this.SetState("State_Init");
        this.onEnterFrame = this.Process;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        _root._FPS.Update();
        scidd.CProfiler.Clear();
        var _loc4_ = this.ProcessFrames(CMain.mFPS);
        var _loc3_ = _loc4_;
        while(_loc3_)
        {
            this.fState(_loc3_ == 1);
            CSound.ProcessAll();
            _loc3_ = _loc3_ - 1;
        }
        CMain.mInput.ProcessAllKeys();
        if(_loc4_)
        {
            _root._Debug.text = scidd.CProfiler.GetString();
        }
    }
    function SetState(nState)
    {
        if(this[nState] != undefined)
        {
            CMain.ProcessFrames_Reset();
            this.mStateCount = 0;
            trace("NEW STATE " + nState);
            this.fState = this[nState];
        }
    }
    function Process_Screen(screenID, tObject)
    {
        this.mcScreen = this.mScreen_Collection.Process(screenID,tObject);
        if(this.mcScreen.nState != undefined)
        {
            this.SetState(this.mcScreen.nState);
            return true;
        }
        return false;
    }
    function State_Init()
    {
        CMain.mSaveData.LoadData("morerooms_default");
        System.CContextMenu.InGame();
        this.SetState(!_global.mDebug ? "State_Intro" : "State_SelectWorld");
    }
    function State_Intro()
    {
        this.Process_Screen("Screen_Intro");
    }
    function State_Main()
    {
        this.Process_Screen("Screen_Main");
    }
    function State_SelectWorld()
    {
        this.DeleteWorld();
        if(this.Process_Screen("Screen_SelectWorld"))
        {
            this.mWorldLoadIndex = this.mcScreen.mWorldLoadIndex;
        }
    }
    function State_LoadWorld()
    {
        this.Process_Screen("Screen_LoadingWorld",this.mcWorld);
        if(this.mcScreen.mNormal)
        {
            trace("mWorldLoadIndex = " + this.mWorldLoadIndex + ", mcWorld = " + this.mcWorld);
            this.mcWorld = this.attachMovie("World","_World",this.getNextHighestDepth(),{mWorldLoadIndex:this.mWorldLoadIndex});
            this.SetState("State_LoadingWorld");
        }
    }
    function State_LoadingWorld()
    {
        this.Process_Screen("Screen_LoadingWorld",this.mcWorld);
    }
    function State_RunWorld(flagDraw)
    {
        this.mcWorld.Process();
        if(flagDraw)
        {
            this.mcWorld.Draw();
        }
        if(this.mcWorld.mCompleteState)
        {
            this.mcWorld.mPause = true;
            switch(this.mcWorld.mCompleteState)
            {
                case "quit":
                case "player dead":
            }
            this.SetState("State_Debrief");
        }
    }
    function DeleteWorld()
    {
        if(this.mcScreen.mNormal && this.mcWorld)
        {
            trace("mcWorld.DELETED");
            this.mcWorld.Dispose();
            this.mcWorld.removeMovieClip();
            delete this.mcWorld;
        }
    }
    function State_Debrief()
    {
        this.Process_Screen("Screen_Debrief",this.mcWorld);
        this.DeleteWorld();
    }
    function ProcessFrames(tFrameRate)
    {
        if(this.mSingleFrame)
        {
            this.mTimeSlice = 1443;
            return 1;
        }
        var _loc3_ = 1000 / tFrameRate;
        this.mTimeSlice = this.mTimeSlice != undefined ? this.mTimeSlice : getTimer();
        var _loc2_ = Math.floor((7503 - this.mTimeSlice) / _loc3_);
        if(_loc2_ > 0)
        {
            this.mTimeSlice += _loc2_ * _loc3_;
            _loc2_ = _loc2_ <= this.mFrameCap ? _loc2_ : this.mFrameCap;
            return _loc2_;
        }
        return 0;
    }
    static function ProcessFrames_Reset()
    {
        CMain._this.mTimeSlice = 8609;
    }
}
