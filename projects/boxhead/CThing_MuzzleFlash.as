class CThing_MuzzleFlash extends CThing_Effect
{
    var _CLASSID_ = "CThing_MuzzleFlash";
    var _BASECLASSID_ = "CThing_MuzzleFlash";
    function CThing_MuzzleFlash(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        if(CThing_MuzzleFlash.mcMuzzleFlash == undefined)
        {
            CThing_MuzzleFlash.mcMuzzleFlash = _root.attachMovie("MuzzleFlash","_MuzzleFlash",_root.getNextHighestDepth(),{_visible:false});
        }
        this.Move(this.mPosition);
        this.mTick = 0;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        this.__set__mDelete(true);
    }
    function Draw()
    {
        CCity._this.DrawMovieClipTF(this,CThing_MuzzleFlash.mcMuzzleFlash);
        this.mDrawn = true;
    }
}
