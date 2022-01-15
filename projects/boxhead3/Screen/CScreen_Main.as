class Screen.CScreen_Main extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_Main";
    function CScreen_Main()
    {
        super();
        this.mcIconPlay.pClass = this;
        this.mcIconPlay.onRelease = function()
        {
            CSound.mSamples.Click.PlaySound();
            this.pClass.nState = "State_SelectWorld";
        };
        this._Film.gotoAndStop(random(this._Film._totalframes) + 1);
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
    }
    function Draw()
    {
        super.Draw();
    }
}
