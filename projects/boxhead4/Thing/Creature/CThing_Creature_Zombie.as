class Thing.Creature.CThing_Creature_Zombie extends Thing.Creature.CThing_Creature
{
    var _CLASSID_ = "CThing_Creature_Zombie";
    function CThing_Creature_Zombie(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mColor = 16711680;
        this.mXSI_Animation = DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.CreateAnimationObject(Thing.Creature.CThing_Creature_Zombie.GetCollection());
        this.Process = this.Process_Init;
    }
    static function GetCollection()
    {
        if(Thing.Creature.CThing_Creature_Zombie.mXSI_Collection)
        {
            return Thing.Creature.CThing_Creature_Zombie.mXSI_Collection;
        }
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection = new DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection();
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_ZOMBIE();
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Zombie_Zombie_Stand","stand"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Zombie_Zombie_Walk","walk"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Zombie_Zombie_Attack","attack"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_HitRear","shothit_1"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_HitFront","shothit_2"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Dying","dying"));
        Thing.Creature.CThing_Creature_Zombie.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Dead","dead"));
        return Thing.Creature.CThing_Creature_Zombie.mXSI_Collection;
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
        super.Process_Init();
        this.mSpeed = 0.02;
        this.SetState("State_EnterMap");
        this.mBrain_Count = this.mUniqueID % 3;
        this.mScore = 100;
        this.mHeight = 1.5;
        this.mDamage = 50;
        this.mSound = new Object();
        this.mSound.Damage = CSound.mSamples["Creature_Zombie_Hit_" + (random(4) + 1) + "_wav"];
        this.mSound.Death = CSound.mSamples["Creature_Zombie_Hit_" + (random(4) + 1) + "_wav"];
        this.mWorld.mUpgrades.Register_Creature_Zombie(this);
    }
    function Process_Normal()
    {
        super.Process_Normal();
    }
    function Brain()
    {
        this.mTarget_Player = this.mThing_Collection.GetClosestPlayer(this.mPosition);
        this.mTarget_Position = this.mTarget_Player.mPosition;
        if(this.mTarget_Player == undefined)
        {
        }
    }
    function State_GotoPlayer_Init()
    {
        this.mBaseStateID = this.mStateID;
        this.mXSI_Animation.SetAnimation("walk");
    }
    function State_GotoPlayer()
    {
        this.Brain();
        var _loc2_ = this.mAngle.__get__mDirection();
        this.mCurrentCell = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215];
        this.mTarget_Angle.__set__mAngle(Math.atan2((this.mTarget_Position.mY & 16777215) + 0.5 - this.mPosition.mY,(this.mTarget_Position.mX & 16777215) + 0.5 - this.mPosition.mX));
        this.mTarget_Direction = this.mTarget_Angle.mDirection;
        var _loc3_ = this.mCurrentCell["NavReal_" + this.mTarget_Direction]();
        if(_loc3_ & World.Map.CMap_Cell.mCollide_Player)
        {
            this.SetState_WithDirection("State_Attack",_loc2_,this.mTarget_Direction);
            return undefined;
        }
        if((this.mTarget_Direction = this.mCurrentCell.Nav_Direction(_loc2_,this.mTarget_Direction,World.Map.CMap_Cell.mCollide_NonMovable,false)) == -1)
        {
            this.SetState("State_Wait");
            return undefined;
        }
        this.SetState_WithDirection_Wait("State_CellToCell",_loc2_,this.mTarget_Direction);
        return undefined;
    }
    function State_Attack_Init()
    {
        this.mXSI_Animation.SetAnimation("attack");
    }
    function State_Attack()
    {
        if(this.mXSI_Animation.Animate(Math.min(0.3 * (this.mSpeed * 25 * 1.5),1)))
        {
            var _loc3_ = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215];
            _loc3_.mAdjacentCells[this.mAngle.__get__mDirection()].Affect(new Thing.Affect.CThing_Affect_ZombieAttack(this,this.mDamage));
            var _loc2_ = this.mReturnStateID;
            this.SetState("State_Sleep");
            this.mStateCount = 10;
            this.mReturnStateID = _loc2_;
        }
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mWorld.mZombie_DrawCount++;
        this.mWorld.mZombie_AvgPosition.x += Thing.CThing.pDraw.x;
        this.mWorld.mZombie_AvgPosition.y += Thing.CThing.pDraw.y;
        this.mXSI_Animation.Render(Thing.CThing.pDraw,this.mAngle,this.mAlpha);
    }
}
