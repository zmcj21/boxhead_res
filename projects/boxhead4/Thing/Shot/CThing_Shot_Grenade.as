class Thing.Shot.CThing_Shot_Grenade extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_Grenade";
    function CThing_Shot_Grenade(tPosition, tAngle, tParent, tDamage, tPower)
    {
        super(tPosition,tAngle,tParent,tDamage);
        this.mPower = tPower;
        this.mEffect = new Thing.Effect.CThing_Effect_Explosion(this.mPosition,this.mAngle,this,this.mDamage);
        if(!Thing.Shot.CThing_Shot_Grenade.mcDrawObject)
        {
            Thing.Shot.CThing_Shot_Grenade.mcDrawObject = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static("Shot.Grenade");
        }
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
        this.mLife = 60;
        this.mMaxLife = 60;
        this.mPosition.mZ = 40 / World.Map.CMap_Cell.mSize.x;
        this.mDelta = this.mAngle.mDelta;
        this.mDelta.mZ = 0.5;
        this.mDelta.ScaleN(1 * this.mPower);
        this.SetRadius(0.1);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        false;
        this.mDelta.mZ -= 0.06;
        if(this.mPosition.mZ + this.mDelta.mZ < 0)
        {
            if((this.mDelta.mZ = Math.abs(this.mDelta.mZ)) <= 0.06)
            {
                this.mDelta.mZ = 0;
            }
            this.mDelta.ScaleN(0.5);
            this.mPosition.mZ = 0;
            true;
        }
        if(this.mWorld.mMap.mCollide.BounceCollide(this))
        {
            true;
            this.mDelta.ScaleN2D(0.25);
        }
        if(this.mDelta.__get__mLength() > 0.06)
        {
            this.PlaySound(CSound.mSamples.Shot_Grenade_Bounce_wav);
        }
        this.Move(this.mPosition.Add(this.mDelta));
        if(--this.mLife == 0)
        {
            this.Process_Explode();
        }
    }
    function Process_Explode()
    {
        this.mThing_Collection.AddThing_Effect(this.mEffect);
        this.Delete();
    }
    function Draw()
    {
        Thing.Shot.CThing_Shot_Grenade.mcDrawObject.Render(this.mWorld.bmCurrentDraw,this.mWorld.GetScreenPosition(this.mPosition),100);
    }
}
