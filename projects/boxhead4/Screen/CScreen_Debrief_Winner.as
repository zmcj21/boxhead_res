class Screen.CScreen_Debrief_Winner extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_Debrief_Winner";
    var mFirstTime = true;
    var mEndText = ["YOU WERE EATEN!","DEATH!","WIMPISH!","YOUR HEAD WAS RIPPED OFF!","GAME OVER!","LOSER!","BLED TO DEATH","DRAINED OF BLOOD"];
    function CScreen_Debrief_Winner()
    {
        super();
        this.tbWinner.text = "PLAYER " + (Screen.CScreen_Debrief_Winner.mWinnerIndex + 1) + " WINS";
        this.mcWinners.gotoAndStop(CMain.mSaveData["mPlayer" + (Screen.CScreen_Debrief_Winner.mWinnerIndex + 1) + "_CharacterIndex"] + 1);
        CSound.mSamples.World_End_wav.PlaySound();
        this.mStatus.text = this.mEndText[random(this.mEndText.length)];
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
        this.DisableSubmitScore();
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
