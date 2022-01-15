class CScreen_Debriefing extends CScreen
{
    var _CLASSID_ = "CScreen_Debriefing";
    function CScreen_Debriefing()
    {
        super();
        CSound.mGameOver.PlaySound();
        this.mUsername.text = CSaveData._this.__get__mUsername() != undefined ? CSaveData._this.__get__mUsername() : "<Enter name>";
        this.mScore.text = CScreen_Debriefing.mLastScore;
        this.mStatus.text = CScreen_Debriefing.mFailureStatus;
        this._SendScore.pClass = this;
        this._SendScore.onPress = function()
        {
            if(this.pClass.mUsername.text != "<Enter name>")
            {
                CSaveData._this.__set__mUsername(this.pClass.mUsername.text);
                this.pClass.SubmitHighscore();
            }
        };
        this._Retry.pClass = this;
        this._Retry.onPress = function()
        {
            this.pClass.RetryLevel();
        };
        this._Exit.pClass = this.mcMain;
        this._Exit.onPress = function()
        {
            this.pClass.SetState(CMain.mState_Main);
            CSound.mClick.PlaySound();
        };
    }
    function RetryLevel()
    {
        CCity.mRetry = true;
        this.mcMain.SetState(CMain.mState_LoadArena);
    }
    function SubmitHighscore()
    {
        this.mcSubmitHighScore = this.attachMovie("Screen.SubmitHighScore","_SubmitHighscore",this.getNextHighestDepth(),{playerName:this.mUsername.text,playerScore:this.mScore.text});
    }
    static function Retry(tStatus)
    {
        if(tStatus == "dead")
        {
            CScreen_Debriefing.mFailureStatus = "YOU DIED!";
            CCity._this.mCompleteState = "dead";
        }
        else if(tStatus == "outoftime")
        {
            CScreen_Debriefing.mFailureStatus = "OUT OF TIME!";
            CCity._this.mCompleteState = "outoftime";
        }
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
        if(this.mcSubmitHighScore != undefined)
        {
            this.mcSubmitHighScore.Process();
            if(CHighscore_Submit.mContinue)
            {
                this.mcSubmitHighScore.Dispose();
                delete this.mcSubmitHighScore;
                this.mUsername.selectable = false;
                this.mUsername._alpha = 50;
                this._SendScore.enabled = false;
                this._SendScore._alpha = 50;
            }
        }
    }
    function Draw()
    {
        super.Draw();
    }
}
