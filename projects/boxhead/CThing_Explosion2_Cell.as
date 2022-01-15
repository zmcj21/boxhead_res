class CThing_Explosion2_Cell extends CThing_Effect
{
    var _CLASSID_ = "CThing_Explosion2_Cell";
    var _BASECLASSID_ = "CThing_Explosion2_Cell";
    function CThing_Explosion2_Cell(tPosition)
    {
        super(tPosition,0,undefined);
        if(CThing_Explosion2_Cell.mcEffect == undefined)
        {
            CThing_Explosion2_Cell.mcEffect = _root.attachMovie("Explosion.2","_Explosion2",_root.getNextHighestDepth(),{_visible:false});
            CThing_Explosion2_Cell.mcEffect.mScale = 1;
        }
        this.mFrameIndex = 1;
        this.Move(this.mPosition);
        this.mDelta = new scidd.Math.CPointXYZ(random(10) - 5,random(10) - 5,random(5));
        this.mDelta = new scidd.Math.CPointXYZ(0,0,0);
    }
    function Process()
    {
        this.mFrameIndex += 2;
        if(this.mFrameIndex >= CThing_Explosion2_Cell.mcEffect._totalframes + 1)
        {
            this.__set__mDelete(true);
        }
        this.mPosition = this.mPosition.Add(this.mDelta);
        this.mDelta.ScaleN(0.8);
    }
    function Draw()
    {
        CThing_Explosion2_Cell.mcEffect.gotoAndStop(this.mFrameIndex);
        CCity._this.DrawMovieClip(this,CThing_Explosion2_Cell.mcEffect);
    }
}
