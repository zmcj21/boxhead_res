class CScreen_Instructions extends CScreen
{
    var _CLASSID_ = "CScreen_Instructions";
    function CScreen_Instructions()
    {
        super();
        this._SpaceBar.pClass = this.mcMain;
        this._SpaceBar.onPress = function()
        {
            this.pClass.SetState(CMain.mState_LoadArena);
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
        if(CMain.mInput.Pressed(CMain.mInput.mKEY_FIRE))
        {
            this.mcMain.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        }
    }
    function Draw()
    {
        super.Draw();
    }
}
