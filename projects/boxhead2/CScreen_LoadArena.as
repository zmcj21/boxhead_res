class CScreen_LoadArena extends CScreen
{
    var _CLASSID_ = "CScreen_LoadArena";
    function CScreen_LoadArena()
    {
        super();
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
        this._Progress.SetProgress(0);
    }
    function Draw()
    {
        super.Draw();
    }
}
