class Thing.Object.CThing_Object_ChargePack extends Thing.Object.CThing_Object
{
    var _CLASSID_ = "CThing_Object_ChargePack";
    function CThing_Object_ChargePack(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition.__get__mCellCentre(),tAngle,tParent);
        this.mDamage = tDamage != undefined ? tDamage : 100;
        this.mFlags |= Thing.CThing.mFlag_SortFloor;
        this.mBiggerBang = 0;
        this.mClusterExplode = 0;
        if(!Thing.Object.CThing_Object_ChargePack.mcDrawObject_Cache)
        {
            Thing.Object.CThing_Object_ChargePack.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Object.ChargePack");
        }
        this.mcDrawObject = Thing.Object.CThing_Object_ChargePack.mcDrawObject_Cache.Clone();
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
        this.mCurrentCell = this.mWorld.mMap.GetCell(this.mPosition.mX,this.mPosition.mY);
        this.mWorld.mUpgrades.Register_Object(this);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        this.mcDrawObject.Animate_Cycle(1 / CMain.mFPS);
        if(this.mDetonate)
        {
            this.mDetonateCounter = CMain.mFPS / 10;
            this.PlaySound(CSound.mSamples.Object_Mine_Detonate_wav);
            this.Process = this.Process_Detonate;
            this.Process();
        }
    }
    function Process_Detonate()
    {
        this.mcDrawObject.Animate_Cycle(1);
        if(--this.mDetonateCounter < 0)
        {
            this.mWorld.mUpgrades.ApplyUpgrade_Object(this);
            var _loc2_ = this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_Explosion(this.mPosition,this.mAngle,this.mParent,this.mDamage));
            _loc2_.mClusterExplode = this.mClusterExplode;
            _loc2_.mBiggerBang = this.mBiggerBang;
            this.Delete();
        }
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mcDrawObject.Render(this.mWorld.bmDraw,Thing.CThing.pDraw,1,100);
    }
}
