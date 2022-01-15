class CThing_ShotHit extends CThing_Effect
{
    var _CLASSID_ = "CThing_ShotHit";
    var _BASECLASSID_ = "CThing_ShotHit";
    function CThing_ShotHit(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        if(CThing_ShotHit.mcShotHit == undefined)
        {
            CThing_ShotHit.mcShotHit = _root.attachMovie("ShotHit","_ShotHit",_root.getNextHighestDepth(),{_visible:false});
            CThing_ShotHit.mcShotHit.mScale = 0.3;
        }
        this.Move(this.mPosition);
        this.mFrameIndex = 0;
        switch(random(3))
        {
            case 0:
                this.PlaySound(CSound.mShotHit1);
                break;
            case 1:
                this.PlaySound(CSound.mShotHit2);
                break;
            case 2:
                this.PlaySound(CSound.mShotHit3);
        }
    }
    function Process()
    {
        this.mFrameIndex++;
        if(this.mFrameIndex >= CThing_ShotHit.mcShotHit._totalframes + 1)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CThing_ShotHit.mcShotHit.gotoAndStop(this.mFrameIndex);
        CCity._this.DrawMovieClip(this,CThing_ShotHit.mcShotHit);
        this.mDrawn = true;
    }
}
