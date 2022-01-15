class CThing_Explosion2 extends CThing_Effect
{
    var _CLASSID_ = "CThing_Explosion2";
    var _BASECLASSID_ = "CThing_Explosion2";
    function CThing_Explosion2(tPosition, tAngle, tID, tOwner, tDamage)
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
        var _loc5_ = 3 * CMapwho.mCellSize.x;
        this.oMapwho.mMapwho.AffectArea(new flash.geom.Rectangle(this.mPosition.mX - _loc5_,this.mPosition.mY - _loc5_,this.mPosition.mX + _loc5_,this.mPosition.mY + _loc5_),CThing_Affect.Explosion(this.mOwner,this,tDamage,_loc5_));
        this.mCells = new Array();
        this.mCreateCellTick = 3;
        CCity._this.Shake(new flash.geom.Point(0,16));
        0;
        while(true)
        {
            this.mCells[this.mCells.length] = new CThing_Explosion2_Cell(this.mPosition,this.mAngle);
            -1;
        }
    }
    function Process()
    {
        if(this.mCells.length == 0)
        {
            this.__set__mDelete(true);
        }
        var _loc2_ = this.mCells.length - 1;
        while(_loc2_ >= 0)
        {
            this.mCells[_loc2_].Process();
            _loc2_ = _loc2_ - 1;
        }
        _loc2_ = this.mCells.length - 1;
        while(_loc2_ >= 0)
        {
            if(this.mCells[_loc2_].mDelete)
            {
                this.mCells[_loc2_].Dispose();
                this.mCells.splice(_loc2_,1);
            }
            _loc2_ = _loc2_ - 1;
        }
    }
    function Draw()
    {
        var _loc2_ = this.mCells.length - 1;
        while(_loc2_ >= 0)
        {
            this.mCells[_loc2_].Draw();
            _loc2_ = _loc2_ - 1;
        }
        this.mDrawn = true;
    }
}
