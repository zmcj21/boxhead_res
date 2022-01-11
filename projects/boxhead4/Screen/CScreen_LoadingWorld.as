class Screen.CScreen_LoadingWorld extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_LoadingWorld";
    var mFirstTime = true;
    function CScreen_LoadingWorld()
    {
        super();
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
        if(this.mObject.mLoaded && this.__get__mNormal())
        {
            this.nState = "State_InitWorld";
            this._visible = false;
        }
    }
    function Draw()
    {
        super.Draw();
    }
}
