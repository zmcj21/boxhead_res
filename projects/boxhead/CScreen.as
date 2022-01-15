class CScreen extends MovieClip
{
    var Draw = 0;
    var _CLASSID_ = "CScreen";
    var _BASECLASSID_ = "CScreen";
    static var mFadeInDuration = 10;
    static var mFadeOutDuration = 10;
    function CScreen()
    {
        super();
        this.mcMain = CMain._this;
        this.mcContainer = this._parent;
        this._visible = false;
        this._Icon_Back.pClass = this;
        this._Icon_Back.onPress = function()
        {
            CSound.mClick.PlaySound();
            this.pClass.GoBack();
        };
    }
    function Dispose()
    {
        this.mState = "delete";
        this.RemoveBitmapCopy();
    }
    function Process()
    {
        this.mStateCount++;
        switch(this.mState)
        {
            case "startfadein":
                this.mState = "fadein";
                this.MakeBitmapCopy();
            case "fadein":
                var _loc2_ = this.mStateCount / CScreen.mFadeInDuration;
                if(_loc2_ >= 1)
                {
                    this.RemoveBitmapCopy();
                    this._visible = true;
                    this.mState = "init";
                    1;
                }
                this.mcContainer.mcBitmapHolder._alpha = 100;
                break;
            case "init":
                this.mState = "normal";
                break;
            case "normal":
                break;
            case "fadeout":
                _loc2_ = this.mStateCount / CScreen.mFadeOutDuration;
                if(_loc2_ >= 1)
                {
                    this.Dispose();
                    1;
                }
                this.mcContainer.mcBitmapHolder._alpha = (1 - 1) * 100;
        }
    }
    function MakeBitmapCopy()
    {
        this.mcContainer.dBMD = new flash.display.BitmapData(this._Size._width,this._Size._height,true,16711680);
        this.mcContainer.mcBitmapHolder = this.mcContainer.createEmptyMovieClip("_BitmapHolder",this.mcContainer.getNextHighestDepth());
        this.mcContainer.mcBitmapHolder.attachBitmap(this.mcContainer.dBMD,2,"auto",true);
        this.mcContainer.dBMD.draw(this);
    }
    function RemoveBitmapCopy()
    {
        this.mcContainer.dBMD.dispose();
        this.mcContainer.mcBitmapHolder.removeMovieClip();
    }
    function Open()
    {
        if(this.mState == "delete")
        {
            return undefined;
        }
        this.mState = "startfadein";
        this.mStateCount = 0;
        this._visible = false;
    }
    function Close()
    {
        if(this.mState != "normal")
        {
            return undefined;
        }
        this.mState = "fadeout";
        this.mStateCount = 0;
        this._visible = false;
        this.MakeBitmapCopy();
    }
    function GoBack()
    {
        this.mcMain.SetState(CMain.mState_Main);
    }
    function GoReturnState()
    {
        this.mcMain.SetState(this.mcMain.mReturnState != undefined ? this.mcMain.mReturnState : CMain.mState_Main);
    }
}
