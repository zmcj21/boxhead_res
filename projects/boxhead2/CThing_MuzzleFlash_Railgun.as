class CThing_MuzzleFlash_Railgun extends CThing_Effect
{
    var _CLASSID_ = "CThing_MuzzleFlash_Railgun";
    var _BASECLASSID_ = "CThing_MuzzleFlash_Railgun";
    function CThing_MuzzleFlash_Railgun(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        if(CThing_MuzzleFlash_Railgun.mcMuzzleFlash == undefined)
        {
            CThing_MuzzleFlash_Railgun.mcMuzzleFlash = _root.attachMovie("MuzzleFlash.Railgun","_MuzzleFlashRailgun",_root.getNextHighestDepth(),{_visible:false});
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
        CCity._this.DrawMovieClipTF(this,CThing_MuzzleFlash_Railgun.mcMuzzleFlash);
        this.mDrawn = true;
    }
}
