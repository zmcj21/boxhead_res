if(!_global.Screen)
{
    _global.Screen = new Object();
}
§§pop();
if(!_global.Screen.CScreen)
{
    var _loc1_ = null;
    Screen.CScreen = function()
    {
        super();
        this._Icon_Back.pClass = this;
        this._Icon_Back.onPress = function()
        {
            CSound.mSamples.Click.PlaySound();
            this.pClass.GoBack();
        };
        this._visible = false;
        this.mScreen_Transition = new Screen.CScreen_Transition();
    };
    Screen.CScreen extends MovieClip;
    var _loc2_ = Screen.CScreen = function()
    {
        super();
        this._Icon_Back.pClass = this;
        this._Icon_Back.onPress = function()
        {
            CSound.mSamples.Click.PlaySound();
            this.pClass.GoBack();
        };
        this._visible = false;
        this.mScreen_Transition = new Screen.CScreen_Transition();
    }.prototype;
    _loc2_.GoBack = function GoBack()
    {
        this.nState = "State_Main";
    };
    _loc2_.toString = function toString()
    {
        return this._CLASSID_;
    };
    _loc2_.Dispose = function Dispose()
    {
        this.removeMovieClip();
    };
    _loc2_.Open = function Open(mcBack)
    {
        this.mScreen_Transition.TransitionIn(this,mcBack);
    };
    _loc2_.__get__mNormal = function get mNormal()
    {
        return this.mScreen_Transition.mState == Screen.CScreen_Transition.mState_Normal;
    };
    _loc2_.Process = function Process()
    {
        this.mScreen_Transition.Process();
    };
    _loc2_.Draw = 0;
    _loc2_._CLASSID_ = "CScreen";
    _loc2_._BASECLASSID_ = "CScreen";
    Screen.CScreen = function()
    {
        super();
        this._Icon_Back.pClass = this;
        this._Icon_Back.onPress = function()
        {
            CSound.mSamples.Click.PlaySound();
            this.pClass.GoBack();
        };
        this._visible = false;
        this.mScreen_Transition = new Screen.CScreen_Transition();
    }.bFlag_Delete = 1;
    §§push(_loc2_.addProperty("mNormal",_loc2_.__get__mNormal,0));
    §§push(ASSetPropFlags(Screen.CScreen.prototype,null,1));
}
§§pop();
