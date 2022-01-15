class Thing.Shot.CThing_Shot_Laser extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_Laser";
    function CThing_Shot_Laser(tPosition, tAngle, tParent, tDamage, tRange)
    {
        super(tPosition,tAngle,tParent,tDamage);
        tRange = tRange != undefined ? tRange : 10;
        this.mDestination = this.mPosition.Add(this.mAngle.__get__mDelta().ScaleN(100));
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
        if(_root._quality != "LOW")
        {
            this.mWorld.mMap.mMapwho.MoveThing(this);
        }
        var _loc3_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,this.mDestination,0.04,Thing.Affect.CThing_Affect.mAffect_Bullet,true);
        if(_loc3_)
        {
            if(_loc3_.mPOI)
            {
                this.mDestination.mX = _loc3_.mPOI.x;
                this.mDestination.mY = _loc3_.mPOI.y;
            }
        }
        this.mWorld.mMap.mAffect.Affect_Line(this,this.mPosition,this.mDestination,0.04,new Thing.Affect.CThing_Affect_Bullet(this.mParent,this,this.mDamage,this.mAngle));
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(--this.mLife == 0)
        {
            this.Delete();
        }
    }
    function Draw()
    {
        var _loc3_ = this.mWorld.GetScreenPosition(this.mPosition);
        var _loc2_ = this.mWorld.GetScreenPosition(this.mDestination);
        DrawPrimitive.CDrawPrimitive_Line.Draw(this.mWorld.mcScratch,_loc3_,_loc2_,3,8421631,this.mAlpha * 0.5);
        DrawPrimitive.CDrawPrimitive_Line.Draw(this.mWorld.mcScratch,_loc3_,_loc2_,2,16777215,this.mAlpha);
    }
}
