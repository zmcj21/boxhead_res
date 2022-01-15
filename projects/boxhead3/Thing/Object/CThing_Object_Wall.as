class Thing.Object.CThing_Object_Wall extends Thing.Object.CThing_Object
{
    var _CLASSID_ = "CThing_Object_Wall";
    function CThing_Object_Wall(tPosition, tAngle, tParent)
    {
        super(tPosition.__get__mCellCentre(),tAngle,tParent);
        this.MakeIDUnique();
        this.Process = this.Process_Init;
        this.Affect_Setup(Thing.Affect.CThing_Affect.mAffect_Bullet | Thing.Affect.CThing_Affect.mAffect_Explosion | Thing.Affect.CThing_Affect.mAffect_ZombieAttack | Thing.Affect.CThing_Affect.mAffect_DevilAttack);
        this.mLife = 1000;
        this.mMaxLife = 1000;
        this.mAlpha = 100;
        if(!Thing.Object.CThing_Object_Wall.mcDrawObject_Cache)
        {
            Thing.Object.CThing_Object_Wall.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Object.Wall");
        }
        this.mcDrawObject = Thing.Object.CThing_Object_Wall.mcDrawObject_Cache.Clone();
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
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.mCurrentCell = this.mWorld.mMap.GetCell(this.mPosition.mX,this.mPosition.mY);
        this.mCurrentCell.mCollide |= World.Map.CMap_Cell.mCollide_Object;
        this.mHeight = 1;
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
        if(!this.GrowRadius(0.48))
        {
            this.Process = this.Process_Normal;
            this.Process();
        }
    }
    function Process_Normal_Init()
    {
        this.SetRadius(0.42);
        this.mFlags |= Thing.CThing.mFlag_Collidable;
        this.Process = this.Process_Sleep;
    }
    function Process_Normal()
    {
        if(this.mAffectors.length)
        {
            this.ProcessAffects();
        }
    }
    function Process_FadeOut()
    {
        this.mAlpha -= 20;
        if(this.mAlpha < 10)
        {
            this.Delete();
        }
    }
    function Affect(tAffect)
    {
        super.Affect(tAffect);
        this.Process = this.Process_Normal;
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mcDrawObject.Render(this.mWorld.bmDraw,Thing.CThing.pDraw,1,this.mAlpha);
    }
    function ProcessAffects()
    {
        for(var _loc3_ in this.mAffectors)
        {
            var _loc2_ = this.mAffectors[_loc3_];
            switch(_loc2_.mType)
            {
                case Thing.Affect.CThing_Affect.mAffect_Bullet:
                case Thing.Affect.CThing_Affect.mAffect_Explosion:
                case Thing.Affect.CThing_Affect.mAffect_ZombieAttack:
                case Thing.Affect.CThing_Affect.mAffect_DevilAttack:
                    _loc2_.AffectThing(this);
                    if(this.mLife <= 0)
                    {
                        this.ClearAffects();
                        this.mFlags |= Thing.CThing.mFlag_Collidable;
                        this.Process = this.Process_FadeOut;
                        this.Process_FadeOut();
                        this.mThing_Collection.AddThing_Effect(new Thing.Effect.CThing_Effect_SmokeCloud(this.mPosition.Clone()));
                        this.mWorld.mMap.mDecal.Draw_ScorchMark(this.mPosition);
                        return undefined;
                    }
                    this.mcDrawObject.GotoToFrame(Math.floor((1 - this.mLife / this.mMaxLife) * this.mcDrawObject.__get__mFrameAmount()));
                    break;
            }
        }
        this.mAffectors = new Array();
        this.Process = this.Process_Sleep;
    }
}
