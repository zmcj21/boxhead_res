class CScreen_Main extends CScreen
{
    var _CLASSID_ = "CScreen_Main";
    function CScreen_Main()
    {
        super();
        this.SoundActive(CSaveData._this.__get__mSoundActive());
        this._IconPlay.pClass = this.mcMain;
        this._IconPlay.onPress = function()
        {
            this.pClass.SetState(CMain.mState_Instructions);
            CSound.mClick.PlaySound();
        };
        this._Sound.pClass = this;
        this._Sound.onPress = function()
        {
            this.pClass.SoundActive(!CSaveData._this.__get__mSoundActive());
            CSound.mClick.PlaySound();
        };
    }
    function SoundActive(tState)
    {
        CSound.mSFXActive = tState;
        CSaveData._this.__set__mSoundActive(tState);
        this._Sound.gotoAndStop(tState != true ? 2 : 1);
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
    }
    function Draw()
    {
        super.Draw();
    }
}
