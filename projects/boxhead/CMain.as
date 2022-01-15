class CMain extends MovieClip
{
    var _CLASSID_ = "CMain";
    static var mState_Init = 0;
    static var mState_Intro = 1;
    static var mState_Main = 2;
    static var mState_Instructions = 3;
    static var mState_LoadArena = 8;
    static var mState_LoadingArena = 9;
    static var mState_InitArena = 10;
    static var mState_RunArena = 11;
    static var mState_Briefing = 12;
    static var mState_Debrief = 13;
    static var mState_GameComplete = 14;
    static var mSaveData = new CSaveData();
    var mSingleFrame = false;
    var mFrameCap = 1;
    function CMain()
    {
        super();
        CMain._this = this;
        var _loc3_ = new scidd.CProfiler();
        this.mScreenSize = new flash.geom.Point(this._Size._width,this._Size._height);
        this.mSound = new CSound(this);
        CMain.mInput = new CInput();
        this.mAnimation = new CAnimation();
        this.AddScreen("Screen.Init",CMain.mState_Init);
        this.AddScreen("Screen.Intro",CMain.mState_Intro);
        this.AddScreen("Screen.Main",CMain.mState_Main);
        this.AddScreen("Screen.Instructions",CMain.mState_Instructions);
        this.AddScreen("Screen.LoadArena",CMain.mState_LoadArena);
        this.AddScreen("",CMain.mState_LoadingArena);
        this.AddScreen("",CMain.mState_RunArena);
        this.AddScreen("Screen.Debriefing",CMain.mState_Debrief);
        this.SetState(CMain.mState_Init);
        this.mFirstTime = true;
        this.onEnterFrame = this.Process;
    }
    function Process()
    {
        _root._FPS.Update();
        scidd.CProfiler.Clear();
        _root._Debug.text = "";
        var _loc4_ = this.ProcessFrames(30);
        var _loc3_ = _loc4_;
        while(_loc3_)
        {
            CMain.mInput.ProcessAllKeys();
            this.ProcessScreens();
            _root.mDebug.text = "";
            var _loc0_ = null;
            if((_loc0_ = this.mState) !== CMain.mState_Init)
            {
                if(_loc0_ !== CMain.mState_Intro)
                {
                    if(_loc0_ !== CMain.mState_Main)
                    {
                        if(_loc0_ !== CMain.mState_Instructions)
                        {
                            if(_loc0_ !== CMain.mState_LoadArena)
                            {
                                if(_loc0_ !== CMain.mState_LoadingArena)
                                {
                                    if(_loc0_ !== CMain.mState_RunArena)
                                    {
                                        if(_loc0_ !== CMain.mState_Briefing)
                                        {
                                            if(_loc0_ !== CMain.mState_Debrief)
                                            {
                                                if(_loc0_ !== CMain.mState_GameComplete)
                                                {
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        this.mcCity.Process();
                                        if(_loc3_ == 1)
                                        {
                                            this.mcCity.Draw();
                                        }
                                        if(this.mcCity.mCompleteState != undefined)
                                        {
                                            CCity.mRetry = false;
                                            switch(this.mcCity.mCompleteState)
                                            {
                                                case "outoftime":
                                                case "dead":
                                                default:
                                                    this.mSound.StopAll();
                                                    this.SetState(CMain.mState_Debrief);
                                                    CMain.mSaveData.SaveData();
                                                    break;
                                                case "quit":
                                                    this.SetState(CMain.mState_Main);
                                                    this.mSound.StopAll();
                                                    CMain.mSaveData.SaveData();
                                                    break;
                                                case "retry":
                                                    this.SetState(CMain.mState_LoadArena);
                                                    this.mSound.StopAll();
                                                    CMain.mSaveData.SaveData();
                                            }
                                            this.mcCity.Dispose();
                                            delete this.mcCity;
                                        }
                                    }
                                }
                                else
                                {
                                    this.mcCity.Setup();
                                    this.SetState(CMain.mState_RunArena);
                                    this.RemoveActiveScreens();
                                    this.mSingleFrame = false;
                                }
                            }
                            else
                            {
                                this._Background._visible = true;
                                if(this.mScreenList[CMain.mState_LoadArena].mcScreen.mState == "normal")
                                {
                                    this.mcCity = this.attachMovie("City.0002","_City",this.getNextHighestDepth(),{});
                                    this.SetState(CMain.mState_LoadingArena);
                                    this.mSingleFrame = true;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                this.mSound.StopAll();
                CMain.mSaveData.LoadData("_default");
                this.SetState(CMain.mState_Intro);
            }
            CSound.ProcessAll();
            this.mStateCount++;
            _root._Debug.text += scidd.CProfiler.GetString();
            _loc3_ = _loc3_ - 1;
        }
    }
    function SetState(nState)
    {
        if(nState == this.mState || this.CanChangeStateTo(nState) == false)
        {
            return false;
        }
        this.mStateCount = 0;
        var _loc3_ = this.mScreenList[nState];
        switch(nState)
        {
            case CMain.mState_Init:
                break;
            case CMain.mState_Intro:
                this.CreateScreen(this.mScreenList[nState]);
                break;
            case CMain.mState_Main:
                this.CreateScreen(this.mScreenList[nState]);
                break;
            case CMain.mState_Instructions:
                this.CreateScreen(this.mScreenList[nState]);
                break;
            case CMain.mState_LoadArena:
                this.CreateScreen(this.mScreenList[nState]);
                break;
            case CMain.mState_LoadingArena:
                break;
            case CMain.mState_RunArena:
                break;
            case CMain.mState_Debrief:
                this.CreateScreen(this.mScreenList[nState]);
        }
        this.mState = nState;
        return true;
    }
    function AddScreen(tLinkID, tState)
    {
        this.mScreenList = this.mScreenList != undefined ? this.mScreenList : new Array();
        var _loc2_ = new Object();
        _loc2_.mState = tState;
        _loc2_.mLinkID = tLinkID;
        this.mScreenList[tState] = _loc2_;
    }
    function CreateScreen(tScreen)
    {
        this.RemoveActiveScreens();
        var _loc3_ = this.getNextHighestDepth();
        tScreen.mcContainer = this.createEmptyMovieClip("_ScreenContainer" + _loc3_,_loc3_);
        tScreen.mcScreen = tScreen.mcContainer.attachMovie(tScreen.mLinkID,"Screen",1);
        tScreen.mcScreen.Open();
    }
    function RemoveScreen(tScreen)
    {
        tScreen.mcScreen.Close();
    }
    function ProcessScreens()
    {
        for(var _loc3_ in this.mScreenList)
        {
            var _loc2_ = this.mScreenList[_loc3_];
            if(_loc2_.mcScreen != undefined)
            {
                _loc2_.mcScreen.Process();
                if(_loc2_.mcScreen.mState == "delete")
                {
                    _loc2_.mcScreen.removeMovieClip();
                    delete _loc2_.mcScreen;
                    _loc2_.mcContainer.removeMovieClip();
                    delete _loc2_.mcContainer;
                }
            }
        }
    }
    function CanChangeStateTo(nState)
    {
        if(this.mScreenList[nState].mLinkID == "")
        {
            return true;
        }
        return true;
    }
    function RemoveActiveScreens()
    {
        for(var _loc3_ in this.mScreenList)
        {
            var _loc2_ = this.mScreenList[_loc3_];
            if(_loc2_.mcScreen != undefined)
            {
                _loc2_.mcScreen.Close();
            }
        }
    }
    function ProcessFrames(tFrameRate)
    {
        if(this.mSingleFrame)
        {
            this.mTimeSlice = 3453;
            return 1;
        }
        this.mTimeSlice = this.mTimeSlice != undefined ? this.mTimeSlice : getTimer();
        var _loc2_ = int((3582 - this.mTimeSlice) / (1000 / tFrameRate));
        if(_loc2_ > 0)
        {
            this.mTimeSlice += _loc2_ * tFrameRate;
            _loc2_ = _loc2_ <= this.mFrameCap ? _loc2_ : this.mFrameCap;
            return _loc2_;
        }
        return 0;
    }
}
