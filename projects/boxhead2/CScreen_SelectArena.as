class CScreen_SelectArena extends CScreen
{
    var _CLASSID_ = "CScreen_SelectArena";
    function CScreen_SelectArena()
    {
        super();
        this._SpaceBar.pClass = this.mcMain;
        this._SpaceBar.onPress = function()
        {
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        this._Icon0001.pClass = this.mcMain;
        this._Icon0001.onPress = function()
        {
            CCity.mLevelIndex = "0001";
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        this._Icon0002.pClass = this.mcMain;
        this._Icon0002.onPress = function()
        {
            CCity.mLevelIndex = "0002";
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        this._Icon0003.pClass = this.mcMain;
        this._Icon0003.onPress = function()
        {
            CCity.mLevelIndex = "0003";
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        this._Icon0004.pClass = this.mcMain;
        this._Icon0004.onPress = function()
        {
            CCity.mLevelIndex = "0004";
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        this._Icon0005.pClass = this.mcMain;
        this._Icon0005.onPress = function()
        {
            CCity.mLevelIndex = "0005";
            this.pClass.SetState(CMain.mState_LoadArena);
            CSound.mClick.PlaySound();
        };
        CCity.mLevelIndex = "0001";
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
