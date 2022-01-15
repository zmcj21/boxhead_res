class CScreen_Main extends CScreen
{
    var _CLASSID_ = "CScreen_Main";
    function CScreen_Main()
    {
        super();
        this._Film.gotoAndStop(random(this._Film._totalframes) + 1);
        this._IconPlay.onRelease = function()
        {
            CMain._this.SetState(CMain.mState_SelectArena);
            CSound.mClick.PlaySound();
        };
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
