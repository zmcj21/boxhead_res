class Screen.CScreen_Debrief extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_Debrief";
    var mFirstTime = true;
    var mEndText = ["YOU WERE EATEN!","DEATH!","WIMPISH!","YOUR HEAD WAS RIPPED OFF!","GAME OVER!","LOSER!","BLED TO DEATH","DRAINED OF BLOOD"];
    function CScreen_Debrief()
    {
        super();
        External.CHighscore_Submit.mGameID = External.CHighscore_Submit.GetGameIDbyLibLink(this.mObject.mWorldLibLink);
        CSound.mSamples.World_End_wav.PlaySound();
        this.mUsername.text = CSaveData._this.__get__mUsername() != undefined ? CSaveData._this.__get__mUsername() : "<Enter name>";
        this.mScore.text = this.mObject.mHud.mScore;
        var _loc4_ = this.mScore.getTextFormat();
        _loc4_.letterSpacing = -2;
        this.mScore.setTextFormat(_loc4_);
        this.mStatus.text = this.mEndText[random(this.mEndText.length)];
        this._SendScore.pClass = this;
        this._SendScore.onRelease = function()
        {
            CSound.mSamples.Click.PlaySound();
            if(this.pClass.mUsername.text != "<Enter name>")
            {
                CSaveData._this.__set__mUsername(this.pClass.mUsername.text);
                External.CTracker.Click_SubmitHighscore();
                if(_global.mCrazyMonkeyGames)
                {
                    this.pClass.SubmitHighscore();
                }
            }
        };
        this._Retry.pClass = this;
        this._Retry.onPress = function()
        {
            this.pClass.nState = "State_LoadWorld";
            CSound.mSamples.Click.PlaySound();
        };
        this._Exit.pClass = this;
        this._Exit.onPress = function()
        {
            this.pClass.nState = "State_SelectWorld";
            CSound.mSamples.Click.PlaySound();
        };
        this._ViewHighscores.pClass = this;
        this._ViewHighscores.onRelease = function()
        {
            if(_global.mCrazyMonkeyGames)
            {
                External.CTracker.Click_ViewHighscore();
                §§push(this.getURL("http://scores.crazymonkeygames.com/hs/listscores.php?id=" + External.CHighscore_Submit.mGameID,"_BLANK"));
            }
        };
        if(!(CMain.mSaveData.mDevilsActive == 1 && CMain.mSaveData.mCollisionsActive == 1 && CMain.mSaveData.mDamageActive == 1))
        {
            this.DisableSubmitScore();
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function SubmitHighscore()
    {
        this.mcSubmitHighScore = this.attachMovie("Screen.SubmitHighScore","_SubmitHighscore",this.getNextHighestDepth(),{playerName:this.mUsername.text,playerScore:this.mScore.text});
    }
    function Process()
    {
        super.Process();
        if(this.mcSubmitHighScore != undefined)
        {
            this.mcSubmitHighScore.Process();
            if(External.CHighscore_Submit.mContinue)
            {
                this.mcSubmitHighScore.Dispose();
                delete this.mcSubmitHighScore;
                this.DisableSubmitScore();
            }
        }
    }
    function DisableSubmitScore()
    {
        this.mUsername.selectable = false;
        this.mUsername._alpha = 50;
        this._SendScore.enabled = false;
        this._SendScore._alpha = 50;
        this._Boundary._alpha = 50;
        this.txtEnterYourName._alpha = 50;
    }
    function Draw()
    {
        super.Draw();
    }
}
