class Thing.Effect.CThing_Effect_Explosion extends Thing.Effect.CThing_Effect
{
    var _CLASSID_ = "CThing_Effect_Explosion";
    function CThing_Effect_Explosion(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition,tAngle,tParent);
        this.MakeIDUnique();
        this.mDamage = tDamage;
        this.mRange = 2 + Math.max(this.mDamage - 100,0) * 0.005;
        this.mDelay = 0;
        this.mBiggerBang = 0;
        this.mClusterExplode = 0;
        if(!Thing.Effect.CThing_Effect_Explosion.mcDrawObject_Cache)
        {
            Thing.Effect.CThing_Effect_Explosion.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Effect.Explosion");
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
        if(this.mClusterExplode)
        {
            0;
            var _loc3_ = Thing.Math.CThing_Angle.PI360 / 4;
            while(0 < Thing.Math.CThing_Angle.PI360)
            {
                var _loc4_ = new Thing.Math.CThing_Angle(0 + Math.random() * (_loc3_ / 2) - _loc3_ / 4);
                this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_ClusterShell(this.mPosition.Clone(),_loc4_,this.mParent,this.mDamage));
                _loc2_ = 0 + _loc3_;
            }
        }
        if(this.mBiggerBang)
        {
            0;
            _loc3_ = Thing.Math.CThing_Angle.PI360 / (this.mBiggerBang * 1.5);
            while(0 < Thing.Math.CThing_Angle.PI360)
            {
                _loc4_ = new Thing.Math.CThing_Angle(0 + Math.random() * (_loc3_ / 4) - _loc3_ / 8);
                var _loc5_ = this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_Explosion(this.mPosition.Add(_loc4_.__get__mDelta()),_loc4_,this.mParent,this.mDamage));
                _loc5_.mDelay = 2 + random(4);
                _loc2_ = 0 + _loc3_;
            }
        }
        this.Process = this.Process_Delay;
        this.Process();
    }
    function Process_Delay()
    {
        if(--this.mDelay >= 0)
        {
            return undefined;
        }
        this.mWorld.Shake(new flash.geom.Point(0,30));
        this.mWorld.mBrightness = 1;
        var _loc2_ = new flash.geom.Rectangle(this.mPosition.mX - this.mRange,this.mPosition.mY - this.mRange,this.mRange * 2,this.mRange * 2);
        this.mWorld.mMap.mAffect.AffectArea(_loc2_,new Thing.Affect.CThing_Affect_Explosion(this.mParent,this,this.mDamage,this.mRange));
        this.mWorld.mBrightness = 1;
        this.mWorld.mMap.mDecal.Draw_ScorchMark(this.mPosition);
        this.PlaySound(CSound.mSamples.Effect_Explosion_wav);
        this.mcDrawObject = Thing.Effect.CThing_Effect_Explosion.mcDrawObject_Cache.Clone();
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(this.mcDrawObject.Animate(2.5))
        {
            this.Delete();
        }
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmCurrentDraw,this.mWorld.GetScreenPosition(this.mPosition),1,100);
    }
}
