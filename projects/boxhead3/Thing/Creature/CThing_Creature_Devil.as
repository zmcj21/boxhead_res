class Thing.Creature.CThing_Creature_Devil extends Thing.Creature.CThing_Creature
{
    var State_TrackTarget = 0;
    var _CLASSID_ = "CThing_Creature_Devil";
    function CThing_Creature_Devil(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mColor = 16711680;
        if(Thing.Creature.CThing_Creature_Devil.mXSI_Collection == undefined)
        {
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection = new DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection();
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.StartRender(0.42);
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_Stand","stand"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_Walk","walk"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_HitRear","shothit_1"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_HitFront","shothit_2"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_Dying","dying"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_Dead","dead"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Devil_Attack","attack"));
            Thing.Creature.CThing_Creature_Devil.mXSI_Collection.EndRender();
        }
        this.mXSI_Animation = DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.CreateAnimationObject(Thing.Creature.CThing_Creature_Devil.mXSI_Collection);
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
    function State_Dead_Init()
    {
        super.State_Dead_Init();
    }
    function Affect_Setup(tFlags)
    {
        super.Affect_Setup(tFlags | Thing.Affect.CThing_Affect.mAffect_PlayerLineOfSight);
    }
    function Process_Init()
    {
        super.Process_Init();
        this.mSpeed = 0.04;
        this.SetRadius(0.42);
        this.mLife = 1000;
        this.mMaxLife = 1000;
        this.mAttackRange = 5;
        this.mAttackDamage = 50;
        this.mMass = 5;
        this.mFireRate = 0;
        this.mScore = 1000;
        this.mHeight = 1.8;
        this.mFireRateCount = 5;
        this.mWorld.mUpgrades.Register_Creature_Zombie(this);
        this.SetState("State_EnterMap");
        this.mSound = new Object();
        this.mSound.Damage = CSound.mSamples["Creature_Zombie_Hit_" + (random(4) + 1) + "_wav"];
        this.mSound.Death = CSound.mSamples["Creature_Zombie_Hit_" + (random(4) + 1) + "_wav"];
    }
    function Process_Normal()
    {
        super.Process_Normal();
        this.mFireRateCount--;
    }
    function Brain()
    {
        this.mTarget_Player = this.mThing_Collection.GetClosestPlayer(this.mPosition);
        this.mTarget_Position = this.mTarget_Player.mPosition;
        if(this.State_Attack_Decision())
        {
            this.mDamageMulitply = false;
            this.mAttackAngle = this.mPosition.CAngleToPosition(this.mTarget_Player.mPosition);
            this.SetState("State_Attack");
            return true;
        }
        this.mCanAttack = true;
        return false;
    }
    function State_GotoPlayer_Init()
    {
        this.mBaseStateID = this.mStateID;
        this.mXSI_Animation.SetAnimation("walk");
    }
    function State_GotoPlayer()
    {
        if(this.Brain())
        {
            return undefined;
        }
        var _loc2_ = this.mAngle.__get__mDirection();
        this.mCurrentCell = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215];
        this.mTarget_Angle.__set__mAngle(Math.atan2((this.mTarget_Position.mY & 16777215) + 0.5 - this.mPosition.mY,(this.mTarget_Position.mX & 16777215) + 0.5 - this.mPosition.mX));
        this.mTarget_Direction = this.mTarget_Angle.mDirection;
        var _loc3_ = this.mCurrentCell["NavReal_" + this.mTarget_Direction]();
        if(!(_loc3_ & World.Map.CMap_Cell.mCollide_Player))
        {
        }
        if(_loc3_ & World.Map.CMap_Cell.mCollide_Object)
        {
            this.mAttackAngle = this.mAngle.Clone();
            this.mAttackAngle.__set__mDirection(this.mAngle.mDirection);
            this.mDamageMulitply = true;
            this.SetState_WithDirection("State_Attack",_loc2_,this.mTarget_Direction);
            return undefined;
        }
        if((this.mTarget_Direction = this.mCurrentCell.Nav_Direction(_loc2_,this.mTarget_Direction,World.Map.CMap_Cell.mCollide_NonMovable,true)) == -1)
        {
            this.SetState("State_Wait");
            return undefined;
        }
        this.SetState_WithDirection_Wait("State_CellToCell",_loc2_,this.mTarget_Direction);
        return undefined;
    }
    function State_Attack_Decision()
    {
        if(!this.mCanAttack || this.mFireRateCount > 0)
        {
            return false;
        }
        if(this.mTarget_Player.mLife <= 0)
        {
            return false;
        }
        var _loc2_ = this.mTarget_Player.mPosition;
        if(this.mPosition.CAngleToPosition(_loc2_).__get__mDirection() != this.mAngle.__get__mDirection())
        {
            return false;
        }
        if(this.mPosition.Distance_SQR(_loc2_) > this.mAttackRange * this.mAttackRange)
        {
            return false;
        }
        var _loc3_ = this.mWorld.mMap.mCollide.Collide_Line(this,this.mPosition,_loc2_,Thing.Shot.CThing_Shot_FireBall.mCollideRadius,Thing.Affect.CThing_Affect.mAffect_PlayerLineOfSight);
        if(_loc3_.mThing._CLASSID_ != this.mTarget_Player._CLASSID_)
        {
            return false;
        }
        return true;
    }
    function State_Attack_Init()
    {
        this.mXSI_Animation.SetAnimation("attack");
    }
    function State_Attack()
    {
        var _loc3_ = this.mXSI_Animation.Animate_RetObj(Math.min(0.2 * (this.mSpeed * 25 * 1.5),1));
        if(_loc3_.mNewFrame && _loc3_.mFrameIndex == 3)
        {
            var _loc5_ = this.mAttackDamage;
            var _loc6_ = this.mAttackSpeed;
            var _loc4_ = this.mAttackAngle;
            this.mXSI_Animation.Update_CurrentFrame(this.mAngle);
            var _loc2_ = this.mXSI_Animation.__get__XSI_Info().XSI_Model_Hand_Right.nPosition;
            _loc2_ = _loc2_.Add(this.mXSI_Animation.__get__XSI_Info().XSI_Model_Hand_Left.nPosition);
            _loc2_ = this.mPosition.Add(_loc2_.ScaleN(0.5));
            if(isNaN(_loc2_.mX) || isNaN(_loc2_.mY))
            {
                _loc2_ = this.mPosition.Clone();
                _loc2_ = _loc2_.Add(_loc4_.__get__mDelta().Normalize(this.mRadius + this.mRadius / 2));
                _loc2_.mZ = 0.84;
            }
            this.mThing_Collection.AddThing_Shot(new Thing.Shot.CThing_Shot_FireBall(_loc2_,_loc4_.Clone(),this,_loc5_,this.mDamageMulitply,_loc6_));
            this.mFireRateCount = this.mFireRate;
        }
        if(_loc3_.mAnimEnd)
        {
            this.SetState(this.mReturnStateID);
        }
    }
    function State_TrackTarget_Init()
    {
        this.mXSI_Animation.SetAnimation("stand");
    }
    function State_RemoveObject_Init()
    {
        this.mXSI_Animation.SetAnimation("stand");
        this.mCurrentCell = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215];
    }
    function State_RemoveObject()
    {
        if(this.mCurrentCell.mAdjacentCells[this.mAngle.__get__mDirection()].mCollide & World.Map.CMap_Cell.mCollide_Object)
        {
            this.mCurrentCell.mAdjacentCells[this.mAngle.__get__mDirection()].Affect(new Thing.Affect.CThing_Affect_DevilAttack(this,this,100000,this.mAngle));
        }
        else
        {
            this.SetState("State_GotoPlayer");
        }
    }
}
