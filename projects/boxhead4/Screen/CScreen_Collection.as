class Screen.CScreen_Collection
{
    var Dispose = 0;
    var Draw = 0;
    var _CLASSID_ = "CScreen_Collection";
    static var mState_Normal = 0;
    static var mState_TransitionIn = 1;
    static var mState_TransitionOut = 2;
    function CScreen_Collection(tmcParent, tScreenSize)
    {
        Screen.CScreen_Transition.mScreenSize = tScreenSize;
        this.mcParent = tmcParent;
        this.mcContainer = this.mcParent.createEmptyMovieClip("_Screen_Collection",this.mcParent.getNextHighestDepth());
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process(idScreen, tObject)
    {
        this.mcScreenFront.Process();
        if(this.mcScreenFront.idScreen != idScreen)
        {
            this.mcScreenBack = this.mcScreenFront;
            this.mcScreenFront = this.mcContainer.attachMovie(idScreen,"_" + idScreen,this.mcContainer.getNextHighestDepth(),{mObject:tObject});
            this.mcScreenFront.idScreen = idScreen;
            this.mcScreenFront.mcParent = this.mcParent;
            this.mcScreenFront.Open(this.mcScreenBack);
        }
        this.mcScreenFront.mObject = tObject;
        return this.mcScreenFront;
    }
}
