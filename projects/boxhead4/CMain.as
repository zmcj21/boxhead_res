class CMain extends MovieClip
{
    var Dispose = 0;
    static var AddPlayers = 0;
    var Draw = 0;
    var State_Instructions = 0;
    var _CLASSID_ = "CMain";
    var _BASECLASSID_ = "CMain";
    static var mFPS = 25;
    static var mInitBGTasks = false;
    static var mTimeAllowedBGTasks = 25;
    var mSingleFrame = false;
    var mFrameCap = 1;
    function CMain()
    {
        super();
        CMain._this = this;
        CMain.mSaveData = new CSaveData();
        CMain.mSaveData.LoadData("morerooms_default");
        CMain.mProfiler = new scidd.CProfiler();
        this.mScreenSize = new flash.geom.Point(this._Size._width,this._Size._height);
        CMain.mSound = new CSound(this);
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
        7120;
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
        CMain.ProcessBGTasks();
    }
    static function ProcessBGTasks()
    {
        var _loc2_ = CMain.mTimeAllowedBGTasks;
        if(!CMain.mInitBGTasks)
        {
            CMain.mInitBGTimeStamp = 7174;
            var _loc3_ = new DrawPrimitive.XSI.CDrawPrimitive_XSI_DI(_global.mXSI_Data.mItems);
            delete _global.mXSI_Data.mItems;
            delete _global.mXSI_Data;
            Thing.Creature.CThing_Creature_Player.GetCollection(CMain.mSaveData.mPlayer1_CharacterIndex);
            Thing.Creature.CThing_Creature_Player.GetCollection(CMain.mSaveData.mPlayer2_CharacterIndex);
            Thing.Creature.CThing_Creature_Devil.GetCollection();
            Thing.Creature.CThing_Creature_Zombie.GetCollection();
            CMain.mInitBGTasks = true;
            1000;
        }
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.RenderStack_Process(CMain.mInitBGTimeStamp,1000);
        CMain.mInitBGTimeStamp = 1418;
    }
    function SetState(nState)
    {
        if(this[nState] != undefined)
        {
            CMain.ProcessFrames_Reset();
            this.mStateCount = 0;
            this.fState = this[nState];
        }
    }
    function Process_Screen(screenID, tObject)
    {
        this.mcScreen = this.mScreen_Collection.Process(screenID,tObject);
        if(this.mcScreen.nState != undefined)
        {
            if(this.mcScreen.nState == "State_SelectWorld")
            {
                this.mcScreen.nState = !this.mReturn_SelectWorld ? "State_SelectWorld_Single" : this.mReturn_SelectWorld;
            }
            this.SetState(this.mcScreen.nState);
            return true;
        }
        return false;
    }
    function State_Init()
    {
        CMain.mInput = new CInput();
        System.CContextMenu.InGame();
        var _loc3_ = new LocalConnection();
        this.SetState(!_global.mDebug ? "State_Intro" : "State_SelectWorld_DeathMatch");
    }
    function State_Intro()
    {
        this.Process_Screen("Screen_Intro");
    }
    function State_Main()
    {
        this.Process_Screen("Screen_Main");
    }
    function State_SelectWorld_Single()
    {
        this.DeleteWorld();
        if(this.Process_Screen("Screen_SelectWorld",{mMode:"Single"}))
        {
            this.mWorldLibLink = this.mcScreen.mWorldLibLink;
            this.mReturn_SelectWorld = "State_SelectWorld_Single";
        }
    }
    function State_SelectWorld_Coop()
    {
        this.DeleteWorld();
        if(this.Process_Screen("Screen_SelectWorld",{mMode:"Coop"}))
        {
            this.mWorldLibLink = this.mcScreen.mWorldLibLink;
            this.mReturn_SelectWorld = "State_SelectWorld_Coop";
        }
    }
    function State_SelectWorld_DeathMatch()
    {
        this.DeleteWorld();
        if(this.Process_Screen("Screen_SelectWorld",{mMode:"DeathMatch"}))
        {
            this.mWorldLibLink = this.mcScreen.mWorldLibLink;
            this.mReturn_SelectWorld = "State_SelectWorld_DeathMatch";
        }
    }
    function State_LoadWorld()
    {
        this.Process_Screen("Screen_LoadingWorld",this.mcWorld);
        if(this.mcScreen.mNormal)
        {
            this.mcWorld = this.attachMovie("World","_World",this.getNextHighestDepth(),{mWorldLibLink:this.mWorldLibLink});
            this.SetState("State_LoadingWorld");
            CMain.mInput = new CInput();
        }
    }
    function State_LoadingWorld()
    {
        this.Process_Screen("Screen_LoadingWorld",this.mcWorld);
    }
    function State_InitWorld()
    {
        var _loc2_ = CMain.mSaveData.mGameSpeed != 0 ? CMain.mSaveData.mGameSpeed : 0.5;
        CMain.mFPS = 25 * _loc2_;
        this.SetState("State_RunWorld");
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
            CMain.mFPS = 25;
            this.mcWorld.mPause = true;
            switch(this.mcWorld.mCompleteState)
            {
                case "error":
                default:
                    this.SetState(this.mReturn_SelectWorld);
                    break;
                case "quit":
                    this.SetState(World.CWorld.mGameMode != "DeathMatch" ? "State_Debrief" : this.mReturn_SelectWorld);
                    break;
                case "player dead":
                    this.SetState("State_Debrief");
                    break;
                case "player1 wins":
                    Screen.CScreen_Debrief_Winner.mWinnerIndex = 0;
                    this.SetState("State_Debrief_Winner");
                    break;
                case "player2 wins":
                    Screen.CScreen_Debrief_Winner.mWinnerIndex = 1;
                    this.SetState("State_Debrief_Winner");
            }
        }
    }
    function DeleteWorld()
    {
        if(this.mcScreen.mNormal && this.mcWorld)
        {
            this.mcWorld.Dispose();
            this.mcWorld.removeMovieClip();
            delete this.mcWorld;
        }
    }
    function State_Debrief_Winner()
    {
        this.Process_Screen("Screen_Debrief_Winner",this.mcWorld);
        this.DeleteWorld();
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
            this.mTimeSlice = 3858;
            return 1;
        }
        var _loc3_ = 1000 / tFrameRate;
        this.mTimeSlice = this.mTimeSlice != undefined ? this.mTimeSlice : getTimer();
        var _loc2_ = Math.floor((7786 - this.mTimeSlice) / _loc3_);
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
        CMain._this.mTimeSlice = 8734;
    }
}
