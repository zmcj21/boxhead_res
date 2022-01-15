class Thing.Shot.CThing_Shot_Devastator extends Thing.Shot.CThing_Shot
{
    var _CLASSID_ = "CThing_Shot_Devastator";
    var mCounter = 0;
    function CThing_Shot_Devastator(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition,tAngle,tParent,tDamage);
        if(!Thing.Shot.CThing_Shot_Devastator.mcDrawObject_Cache)
        {
            Thing.Shot.CThing_Shot_Devastator.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Shot.Devastator");
        }
        this.mcDrawObject = Thing.Shot.CThing_Shot_Devastator.mcDrawObject_Cache.Clone();
        this.mDelta = this.mAngle.__get__mDelta().ScaleN(0.9);
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
        this.SetRadius(0.25);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        var _loc2_ = this.mPosition.Add(this.mDelta);
        var _loc3_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,_loc2_,0.04,Thing.Affect.CThing_Affect.mAffect_Bullet);
        if(_loc3_)
        {
            if(_loc3_.mCollideType == "wall")
            {
                this.Delete();
                return undefined;
            }
        }
        if(!(this.mCounter++ % 2) && this.mCounter >= 4)
        {
            this._FireLine(this.mAngle.Clone().Add(1.5707963267948966));
            this._FireLine(this.mAngle.Clone().Sub(1.5707963267948966));
        }
        this.Move(_loc2_);
        this.mcDrawObject.Animate_Cycle(1);
    }
    function _FireLine(a)
    {
        var _loc5_ = this.mWorld.mMap;
        var _loc4_ = a.__get__mDelta().ScaleN(0.4);
        var _loc2_ = this.mPosition.Add(_loc4_);
        _loc2_.mZ = 0;
        _loc4_.ScaleN(2);
        8;
        while(true)
        {
            if(_loc5_.GetCell(_loc2_.mX,_loc2_.mY).mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable)
            {
                break;
            }
            this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_Explosion(_loc2_,this.mAngle.Clone(),this,200));
            7;
            8;
            _loc2_ = _loc2_.Add(_loc4_);
        }
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmDraw,this.mWorld.GetScreenPosition(this.mPosition),1,100);
    }
}
