class Thing.Shot.CThing_Shot_Bullet extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_Bullet";
    static var pDraw = new flash.geom.Point();
    function CThing_Shot_Bullet(tPosition, tAngle, tParent, tDamage, tRange, tDelay)
    {
        super(tPosition,tAngle,tParent,tDamage);
        this.mDelay = tDelay != undefined ? tDelay : false;
        tRange = tRange != undefined ? tRange : 10;
        this.mDestination = this.mPosition.Add(new Thing.Math.CThing_Position(1,0,0).RotateZ(this.mAngle.__get__mAngle()).Normalize(tRange));
        this.mLife = 2;
        this.mMaxLife = 2;
        this.mDelta = new Thing.Math.CThing_Position(0,(random(4) + 2) / World.Map.CMap_Cell.mSize.x,(random(4) + 2) / World.Map.CMap_Cell.mSize.y).RotateZ(this.mAngle.__get__mAngle());
        this.mAlpha = 75;
        this.Process = !this.mDelay ? this.Process_Init : this.Process_Delay;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process_Delay()
    {
        this.Process = this.Process_Init;
    }
    function Process_Init()
    {
        if(_root._quality != "LOW")
        {
            this.mWorld.mMap.mMapwho.MoveThing(this);
        }
        var _loc3_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,this.mDestination,0.04,Thing.Affect.CThing_Affect.mAffect_Bullet);
        if(_loc3_)
        {
            if(_loc3_.mPOI)
            {
                this.mDestination.mX = _loc3_.mPOI.x;
                this.mDestination.mY = _loc3_.mPOI.y;
            }
            if(_loc3_.mCollideType == "thing")
            {
                _loc3_.mThing.Affect(new Thing.Affect.CThing_Affect_Bullet(this.mParent,this,this.mDamage,this.mAngle));
            }
            if(_loc3_.mCollideType == "wall")
            {
            }
            if(random(3) == 0 && _root._quality != "LOW")
            {
                this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_BulletHit(this.mDestination.Clone()));
            }
            this.PlaySound(CSound.mSamples["Shot_HitWall_" + (random(3) + 1) + "_wav"]);
        }
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
        var _loc3_ = this.mWorld.GetScreenPosition(this.mPosition);
        var _loc2_ = this.mWorld.GetScreenPosition(this.mDestination);
        DrawPrimitive.CDrawPrimitive_Line.Draw(this.mWorld.mcScratch,_loc3_,_loc2_,0.5,13421772,this.mAlpha);
    }
}
