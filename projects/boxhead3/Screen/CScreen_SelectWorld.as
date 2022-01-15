class Screen.CScreen_SelectWorld extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_SelectWorld";
    var mFirstTime = true;
    function CScreen_SelectWorld()
    {
        super();
        8;
        while(true)
        {
            this.RegisterLevelIcon(this["mcLevel0008"],8);
            7;
        }
        this._ViewHighscore._visible = false;
        var _loc4_ = [this._Level_Beginner,this._Level_Intermediate,this._Level_Expert,this._Level_Nightmare];
        0;
        while(0 < _loc4_.length)
        {
            this.RegisterDifficulty(_loc4_[0],_loc4_,0);
            1;
        }
    }
    function RegisterDifficulty(mc, tList, tIndex)
    {
        mc._Selected._visible = CMain.mSaveData.__get__mDifficulty() == tIndex;
        mc.mIndex = tIndex;
        mc.mList = tList;
        mc.onRelease = function()
        {
            if(this._Selected._visible)
            {
                return undefined;
            }
            for(var _loc2_ in this.mList)
            {
                this.mList[_loc2_]._Selected._visible = false;
            }
            CSound.mSamples.Click.PlaySound();
            CMain.mSaveData.__set__mDifficulty(this.mIndex);
            this._Selected._visible = true;
        };
    }
    function RegisterLevelIcon(mc, levelIndex)
    {
        mc.pClass = this;
        mc._ViewHighscoreonRelease = function()
        {
            CSound.mSamples.Click.PlaySound();
        };
        mc.mID = levelIndex;
        mc._alpha = 50;
        mc.onRelease = function()
        {
            CSound.mSamples.Click.PlaySound();
            this.pClass.nState = "State_LoadWorld";
            this.pClass.mWorldLoadIndex = levelIndex;
            CMain.mSaveData.__set__mPlayCount(CMain.mSaveData.__get__mPlayCount() + 1);
            External.CTracker.Click_PlayCount(CMain.mSaveData.__get__mPlayCount());
        };
        mc.onRollOver = function()
        {
            this._alpha = 100;
            this.pClass.SetHighScore(this);
        };
        mc.onRollOut = function()
        {
            this._alpha = 50;
        };
    }
    function SetHighScore(mc)
    {
        this._ViewHighscore._visible = true;
        this._ViewHighscore._x = mc._x + mc._width / 2;
        this._ViewHighscore._y = mc._y;
        this._ViewHighscore.mcTarget = mc;
        this._ViewHighscore.onRelease = function()
        {
            trace("Gethighscore for " + this.mcTarget.mID);
            External.CTracker.Click_ViewHighscore();
            this.getURL("http://scores.crazymonkeygames.com/hs/listscores.php?id=" + External.CHighscore_Submit.GetGameID(this.mcTarget.mID),"_BLANK");
        };
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
        if(this.mScreen_Transition.mState == Screen.CScreen_Transition.mState_Normal)
        {
        }
    }
    function Draw()
    {
        super.Draw();
    }
}
