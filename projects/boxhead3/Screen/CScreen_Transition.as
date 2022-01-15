class Screen.CScreen_Transition
{
    var Dispose = 0;
    var Draw = 0;
    var _CLASSID_ = "CScreen_Transition";
    var _BASECLASSID_ = "CScreen_Transition";
    static var mState_TransitionIn = 0;
    static var mState_Normal = 2;
    var mTransitionIn_Time = 30;
    var mTransitionOut_Time = 30;
    var mTransitionIn_InFront = true;
    function CScreen_Transition()
    {
        this.mTick = 0;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function TransitionIn(tmcIN, tmcOUT)
    {
        this.mState = Screen.CScreen_Transition.mState_TransitionIn;
        this.mState_CountTarget = this.mTransitionIn_Time;
        this.mState_Count = 0;
        this.mcIN = tmcIN;
        this.mcOUT = tmcOUT;
    }
    function TransitionIn_Process()
    {
        if(this.bmIN == undefined)
        {
            this.mcContainer = this.mcIN._parent.createEmptyMovieClip("_ScreenTransition_Container",this.mcIN._parent.getNextHighestDepth());
            this.mcContainer_OUT = this.mcContainer.createEmptyMovieClip("_OUT",this.mcContainer.getNextHighestDepth());
            this.mcContainer_IN = this.mcContainer.createEmptyMovieClip("_IN",this.mcContainer.getNextHighestDepth());
            this.bmIN = new flash.display.BitmapData(Screen.CScreen_Transition.mScreenSize.x,Screen.CScreen_Transition.mScreenSize.y,false,0);
            this.bmOUT = new flash.display.BitmapData(Screen.CScreen_Transition.mScreenSize.x,Screen.CScreen_Transition.mScreenSize.y,false,0);
            this.bmIN.draw(this.mcIN);
            this.bmOUT.draw(_root);
            this.mcContainer_IN.attachBitmap(this.bmIN,1);
            this.mcContainer_OUT.attachBitmap(this.bmOUT,1);
            this.mcContainer_IN.filters = [new flash.filters.DropShadowFilter()];
            this.mcOUT.removeMovieClip();
            this.mcContainer_IN._alpha = 0;
        }
        this.mcContainer_IN._alpha += 10;
        this.mcContainer_OUT._alpha -= 10;
        if(this.mcContainer_IN._alpha >= 100)
        {
            this.bmIN.dispose();
            this.bmOUT.dispose();
            delete this.bmIN;
            delete this.bmOUT;
            this.mcContainer_OUT.removeMovieClip();
            this.mcContainer_IN.removeMovieClip();
            this.mcContainer.removeMovieClip();
            return true;
        }
        return false;
    }
    function Process()
    {
        switch(this.mState)
        {
            case Screen.CScreen_Transition.mState_TransitionIn:
                this.mState_Count++;
                if(this.TransitionIn_Process())
                {
                    this.mcIN._visible = true;
                    this.mState = Screen.CScreen_Transition.mState_Normal;
                    break;
                }
                break;
            case Screen.CScreen_Transition.mState_Normal:
        }
    }
}
