class Thing.Object.CThing_Object_Mine extends Thing.Object.CThing_Object
{
    var _CLASSID_ = "CThing_Object_Mine";
    function CThing_Object_Mine(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition.__get__mCellCentre(),tAngle,tParent);
        this.mDamage = tDamage != undefined ? tDamage : 100;
        this.mFlags |= Thing.CThing.mFlag_SortFloor;
        if(!Thing.Object.CThing_Object_Mine.mcDrawObject_Cache)
        {
            Thing.Object.CThing_Object_Mine.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Object.Mine");
        }
        this.mcDrawObject = Thing.Object.CThing_Object_Mine.mcDrawObject_Cache.Clone();
        this.mBiggerBang = 0;
        this.mClusterExplode = 0;
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
        this.mTestFlags = World.Map.CMap_Cell.mCollide_Creature | (World.CWorld.mGameMode != "DeathMatch" ? 0 : World.Map.CMap_Cell.mCollide_Player);
        this.Process = World.CWorld.mGameMode != "DeathMatch" ? this.Process_Normal : this.Process_WaitForCollideFlags0;
        this.Process();
    }
    function Process_WaitForCollideFlags0()
    {
        if((this.mCurrentCell.mCollide & this.mTestFlags) == 0)
        {
            this.Process = this.Process_Normal;
        }
    }
    function Process_Normal()
    {
        this.mcDrawObject.Animate_Cycle(1 / CMain.mFPS);
        if(this.mCurrentCell.mCollide & this.mTestFlags)
        {
            this.mDetonateCounter = CMain.mFPS * 2;
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
        this.mcDrawObject.Render(this.mWorld.bmCurrentDraw,Thing.CThing.pDraw,1,100);
    }
}
