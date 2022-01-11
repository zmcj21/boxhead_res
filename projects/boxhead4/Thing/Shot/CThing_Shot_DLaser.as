class Thing.Shot.CThing_Shot_DLaser extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_DLaser";
    static var pDraw = new flash.geom.Point();
    function CThing_Shot_DLaser(tPosition, tAngle, tParent, tDamage, tRange)
    {
        super(tPosition,tAngle,tParent,tDamage,tRange);
        tRange = tRange != undefined ? tRange : 10;
        this.mDestination = this.mPosition.Add(new Thing.Math.CThing_Position(1,0,0).RotateZ(this.mAngle.__get__mAngle()).Normalize(tRange));
        this.mLife = 2;
        this.mMaxLife = 2;
        this.mDelta = new Thing.Math.CThing_Position(0,(random(4) + 2) / World.Map.CMap_Cell.mSize.x,(random(4) + 2) / World.Map.CMap_Cell.mSize.y).RotateZ(this.mAngle.__get__mAngle());
        this.mAlpha = 75;
        this.Process = this.Process_Init;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process_Init()
    {
        this.mWorld.mMap.mMapwho.MoveThing(this);
        var _loc2_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,this.mDestination,0.04,Thing.Affect.CThing_Affect.mAffect_Bullet,true);
        if(_loc2_)
        {
            if(_loc2_.mPOI)
            {
                this.mDestination.mX = _loc2_.mPOI.x;
                this.mDestination.mY = _loc2_.mPOI.y;
            }
        }
        this.mWorld.mMap.mAffect.Affect_Line(this,this.mPosition,this.mDestination,0.04,new Thing.Affect.CThing_Affect_Bullet(this.mParent,this,this.mDamage,this.mAngle));
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        this.mDelta.ScaleN(0.75);
        this.mDestination.mX += this.mDelta.mX * 0.5;
        this.mDestination.mY += this.mDelta.mY * 0.5;
        this.mDestination.mZ += this.mDelta.mZ * 0.5;
        this.mPosition.mX += this.mDelta.mX;
        this.mPosition.mY += this.mDelta.mY;
        this.mPosition.mZ += this.mDelta.mZ;
        if(--this.mLife == 0)
        {
            this.Delete();
        }
    }
    function Draw()
    {
        var _loc3_ = this.mPosition.ConvertCellToScreen();
        var _loc2_ = this.mDestination.ConvertCellToScreen();
        DrawPrimitive.CDrawPrimitive_Line.Draw(this.mWorld.mcScratch,_loc3_,_loc2_,3,10053375,this.mAlpha * 0.5);
        DrawPrimitive.CDrawPrimitive_Line.Draw(this.mWorld.mcScratch,_loc3_,_loc2_,2,10053375,this.mAlpha);
    }
}
