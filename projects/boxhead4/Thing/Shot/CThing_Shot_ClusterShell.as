class Thing.Shot.CThing_Shot_ClusterShell extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_ClusterShell";
    function CThing_Shot_ClusterShell(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition,tAngle,tParent,tDamage);
        this.mMaxLife = this.mLife = 16 + random(8);
        this.mDelta = this.mAngle.mDelta;
        this.mDelta.ScaleN(1 * (0.05 + Math.random() * 0.05));
        this.mDelta.mZ = 0.5;
        this.SetRadius(0.1);
        if(!Thing.Shot.CThing_Shot_ClusterShell.mcDrawObject)
        {
            Thing.Shot.CThing_Shot_ClusterShell.mcDrawObject = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static("Shot.ClusterShell");
        }
        this.Process = this.Process_Normal;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
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
            this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_Explosion(this.mPosition,this.mAngle,this,this.mDamage));
            this.Delete();
        }
    }
    function Draw()
    {
        Thing.Shot.CThing_Shot_ClusterShell.mcDrawObject.Render(this.mWorld.bmCurrentDraw,this.mWorld.GetScreenPosition(this.mPosition),100);
    }
}
