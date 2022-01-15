class CThing_Explosion2 extends CThing_Effect
{
    var _CLASSID_ = "CThing_Explosion2";
    var _BASECLASSID_ = "CThing_Explosion2";
    function CThing_Explosion2(tPosition, tAngle, tID, tOwner, tDamage, tBigBang)
    {
        super(tPosition,tAngle,tID);
        if(CThing_Explosion2.mcEffect == undefined)
        {
            CThing_Explosion2.mcEffect = _root.attachMovie("Explosion.2","_Explosion2",_root.getNextHighestDepth(),{_visible:false});
            CThing_Explosion2.mcEffect.mScale = 1;
        }
        this.mFrameIndex = 1;
        this.mAlpha = 100;
        this.mOwner = tOwner;
        this.PlaySound(CSound.mExplosion1);
        this.Move(this.mPosition);
        this.mDelta = new scidd.Math.CPointXYZ(0,0,5);
        this.mSize = tDamage / 166.66666666666666 * CMapwho.mCellSize.x;
        this.oMapwho.mMapwho.AffectArea(new flash.geom.Rectangle(this.mPosition.mX - this.mSize,this.mPosition.mY - this.mSize,this.mPosition.mX + this.mSize,this.mPosition.mY + this.mSize),CThing_Affect.Explosion(this.mOwner,this,tDamage,this.mSize));
        CThing_Explosion2.mcEffect.mScale = this.mSize / CMapwho.mCellSize.x * 2 * 0.66;
        this.mCells = new Array();
        this.mCreateCellTick = 3;
        CCity._this.Shake(new flash.geom.Point(0,16));
        CCity.mBrightness = 1;
        if(tBigBang)
        {
            0;
            while(true)
            {
                var _loc5_ = this.mPosition.Add(new scidd.Math.CPointXYZ(random(128) - 64,random(128) - 64,0));
                CThing.AddThing(new CThing_Explosion2(_loc5_,0,this.mID,this,250 + random(250),false));
                1;
            }
        }
    }
    function Process()
    {
        this.mFrameIndex += 2;
        if(this.mFrameIndex >= CThing_Explosion2.mcEffect._totalframes + 1)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CThing_Explosion2.mcEffect.gotoAndStop(this.mFrameIndex);
        CCity._this.DrawMovieClip(this,CThing_Explosion2.mcEffect);
        this.mDrawn = true;
    }
}
