class Thing.Object.CThing_Object_Barrel extends Thing.Object.CThing_Object
{
    var _CLASSID_ = "CThing_Object_Barrel";
    function CThing_Object_Barrel(tPosition, tAngle, tParent, tDamage)
    {
        super(tPosition.__get__mCellCentre(),tAngle,tParent);
        this.MakeIDUnique();
        this.mDamage = tDamage != undefined ? tDamage : 100;
        if(!Thing.Object.CThing_Object_Barrel.mcDrawObject)
        {
            Thing.Object.CThing_Object_Barrel.mcDrawObject = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static("Object.Barrel");
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
        this.mCurrentCell.mCollide &= World.Map.CMap_Cell.mCollide_Object ^ -1;
    }
    function Process_Init()
    {
        this.Affect_Setup(Thing.Affect.CThing_Affect.mAffect_Bullet | Thing.Affect.CThing_Affect.mAffect_Explosion | Thing.Affect.CThing_Affect.mAffect_DevilAttack | Thing.Affect.CThing_Affect.mAffect_FireBall);
        this.mBiggerBang = 0;
        this.mClusterExplode = 0;
        this.mLife = 1;
        this.mMaxLife = 1;
        this.mHeight = 1;
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.mCurrentCell = this.mWorld.mMap.GetCell(this.mPosition.mX,this.mPosition.mY);
        this.mCurrentCell.mCollide |= World.Map.CMap_Cell.mCollide_Object;
        this.mWorld.mUpgrades.Register_Object(this);
        this.Process = !(this.mCurrentCell.mCollide & World.Map.CMap_Cell.mCollide_Player) ? this.Process_Normal_Init : this.Process_PlayerOnCell;
        this.Process();
    }
    function Process_PlayerOnCell()
    {
        if(this.mCurrentCell.mCollide & World.Map.CMap_Cell.mCollide_Player)
        {
            return undefined;
        }
        this.mFlags |= Thing.CThing.mFlag_Collidable;
        this.Process = this.Process_GrowRadius;
        this.Process();
    }
    function Process_GrowRadius()
    {
        if(!this.GrowRadius(0.42))
        {
            this.Process = this.Process_Normal_Init;
            this.Process();
        }
    }
    function Process_Normal_Init()
    {
        this.SetRadius(0.42);
        this.mFlags |= Thing.CThing.mFlag_Collidable;
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(this.mAffectors.length)
        {
            this.ProcessAffects();
        }
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        Thing.Object.CThing_Object_Barrel.mcDrawObject.Render(this.mWorld.bmCurrentDraw,Thing.CThing.pDraw,100);
    }
    function ProcessAffects()
    {
        var _loc4_ = this.mAffectors;
        this.mAffectors = new Array();
        for(var _loc5_ in _loc4_)
        {
            var _loc3_ = _loc4_[_loc5_];
            switch(_loc3_.mType)
            {
                case Thing.Affect.CThing_Affect.mAffect_DevilAttack:
                case Thing.Affect.CThing_Affect.mAffect_Bullet:
                case Thing.Affect.CThing_Affect.mAffect_FireBall:
                case Thing.Affect.CThing_Affect.mAffect_Explosion:
                    this.mWorld.mUpgrades.ApplyUpgrade_Object(this);
                    this.Delete();
                    var _loc2_ = this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_Explosion(this.mPosition,this.mAngle,this.mParent,this.mDamage));
                    _loc2_.mClusterExplode = this.mClusterExplode;
                    _loc2_.mBiggerBang = this.mBiggerBang;
                    return undefined;
            }
        }
    }
}
