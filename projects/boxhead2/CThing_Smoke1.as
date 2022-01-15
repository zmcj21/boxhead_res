class CThing_Smoke1 extends CThing_Effect
{
    var _CLASSID_ = "CThing_Smoke1";
    var _BASECLASSID_ = "CThing_Smoke1";
    function CThing_Smoke1(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        if(CThing_Smoke1.bmObject == undefined)
        {
            var _loc4_ = _root.attachMovie("Smoke1","_Smoke1",_root.getNextHighestDepth());
            CThing_Smoke1.bmObject = CCity.RenderToBitmap(_loc4_,1);
            _loc4_.removeMovieClip();
        }
        this.mFrameIndex = 1;
        this.Move(this.mPosition);
        this.mDelta = new scidd.Math.CPointXYZ(5,0,0).RotateZ(this.mAngle + 3.141592653589793);
    }
    function Process()
    {
        CThing_Smoke1.bmObject.mFrameIndex++;
        if(CThing_Smoke1.bmObject.mFrameIndex >= CThing_Smoke1.bmObject.mFrameAmount)
        {
            this.__set__mDelete(true);
        }
        this.Move(this.mPosition.Add(this.mDelta));
        this.mDelta.ScaleN(1.2);
    }
    function Draw()
    {
        CThing_Smoke1.bmObject.mFrameIndex = Math.floor(this.mFrameIndex);
        CCity._this.DrawBitmap(this,CThing_Smoke1.bmObject);
        this.mDrawn = true;
    }
}
