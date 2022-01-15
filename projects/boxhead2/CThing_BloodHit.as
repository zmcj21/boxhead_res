class CThing_BloodHit extends CThing_Effect
{
    var _CLASSID_ = "CThing_BloodHit";
    var _BASECLASSID_ = "CThing_BloodHit";
    function CThing_BloodHit(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle + (Math.random() - 0.5) * 2 * 0.2617993877991494,tID);
        if(CThing_BloodHit.mcBloodHit == undefined)
        {
            CThing_BloodHit.mcBloodHit = _root.attachMovie("BloodHit2","_BloodHit",_root.getNextHighestDepth(),{_visible:false});
            CThing_BloodHit.mcBloodHit.mScale = 1;
        }
        this.mOwner = tOwner;
        this.mOffsetZ = random(10) + 15;
        this.Move(this.mOwner.mPosition);
        this.mFrameIndex = 0;
    }
    function Process()
    {
        var _loc2_ = this.mOwner.mPosition.Clone();
        _loc2_.mZ += this.mOffsetZ;
        this.Move(_loc2_);
        this.mFrameIndex += 2;
        if(this.mFrameIndex > CThing_BloodHit.mcBloodHit._Front._totalframes)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CThing_BloodHit.mcBloodHit._Front.gotoAndStop(this.mFrameIndex);
        CThing_BloodHit.mcBloodHit._Top.gotoAndStop(this.mFrameIndex);
        CCity._this.DrawMovieClipTF(this,CThing_BloodHit.mcBloodHit);
        this.mDrawn = true;
    }
}
