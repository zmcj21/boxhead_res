class Thing.Shot.CThing_Shot_Rocket extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_Rocket";
    function CThing_Shot_Rocket(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition,tAngle,tParent,tDamage);
        if(!Thing.Shot.CThing_Shot_Rocket.mcDrawObject_Cache)
        {
            Thing.Shot.CThing_Shot_Rocket.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Shot.Rocket");
        }
        this.mEffect = new Thing.Effect.CThing_Effect_Explosion(this.mPosition,this.mAngle,this,this.mDamage);
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
        this.mcDrawObject = Thing.Shot.CThing_Shot_Rocket.mcDrawObject_Cache.Clone();
        this.mDelta = this.mAngle.__get__mDelta().ScaleN(0.5);
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.SetRadius(0.25);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(random(2))
        {
            this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_RocketSmoke(this.mPosition.Clone(),this.mAngle));
        }
        this.mDelta.ScaleN(1.1);
        var _loc3_ = this.mPosition.Add(this.mDelta);
        var _loc2_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,_loc3_,0.04,Thing.Affect.CThing_Affect.mAffect_Bullet);
        if(_loc2_)
        {
            if(!_loc2_.mPOI)
            {
            }
            if(_loc2_.mCollideType == "thing")
            {
            }
            this.Process_Explode();
            return undefined;
        }
        this.Move(_loc3_);
        this.mcDrawObject.Animate_Cycle(1);
    }
    function Process_Explode()
    {
        this.Delete();
        this.mThing_Collection.AddThing_Effect(this.mEffect);
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmCurrentDraw,this.mWorld.GetScreenPosition(this.mPosition),1,100);
    }
}
