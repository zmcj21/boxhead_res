class Thing.Creature.CThing_Creature extends Thing.CThing
{
    var State_Stand = 0;
    var _CLASSID_ = "CThing_Creature";
    var _BASECLASSID_ = "CThing_Creature";
    static var mAnimationSpeed = 1;
    function CThing_Creature(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mFlags |= Thing.CThing.mFlag_Collidable;
        this.mAlpha = 100;
        this.mMass = 1;
        this.mTarget_Angle = new Thing.Math.CThing_Angle(0);
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
        this.SetRadius(0.45);
        this.mHeight = 1.5;
        this.Move(this.mPosition.__get__mCellCentre());
        this.mMapwho = this.mWorld.mMap.mMapwho;
        this.mMap = this.mWorld.mMap;
        this.Process = this.Process_Normal;
        this.mLife = 100;
        this.mMaxLife = 100;
        this.Process();
    }
    function Process_Normal()
    {
        scidd.CProfiler.Timer_Start(this._CLASSID_ + ".Process");
        if(this.mAffectors.length)
        {
            this.ProcessAffects();
        }
        this.fState();
        scidd.CProfiler.Timer_Stop(this._CLASSID_ + ".Process");
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mXSI_Animation.Render(Thing.CThing.pDraw,this.mAngle,this.mAlpha);
    }
    function SetState_WithDirection(nState, cDirection, tDirection)
    {
        if(tDirection == cDirection)
        {
            this.SetState(nState);
            return undefined;
        }
        this.mTarget_Angle.__set__mDirection(tDirection);
        this.SetState("State_Turn");
        return undefined;
    }
    function SetState_WithDirection_Wait(nState, cDirection, tDirection)
    {
        if(tDirection == cDirection)
        {
            this.SetState(nState);
            return undefined;
        }
        if(this.mReturnStateID == "State_Turn")
        {
            this.SetState("State_Sleep");
            this.mStateCount = CMain.mFPS / 3;
            return undefined;
        }
        this.mTarget_Angle.__set__mDirection(tDirection);
        this.SetState("State_Turn");
        return undefined;
    }
    function SetState(nState)
    {
        if(this[nState] != undefined)
        {
            this.mReturnStateID = this.mStateID;
            this.mStateID = nState;
            this.mStateCount = 0;
            this.fState = this[nState];
            this[nState + "_Init"]();
        }
        else
        {
            trace(this._CLASSID_ + "::Error invalid state = " + nState);
        }
    }
    function State_GotoPosition_Init()
    {
        this.mBaseStateID = this.mStateID;
    }
    function State_GotoPosition()
    {
        var _loc2_ = random(8);
        if(_loc2_ != this.mAngle.__get__mDirection())
        {
            this.mTarget_Angle.__set__mDirection(_loc2_);
            this.SetState("State_Turn");
            return undefined;
        }
        this.SetState("State_CellToCell");
    }
    function State_Wander_Init()
    {
        this.mBaseStateID = this.mStateID;
    }
    function State_Wander()
    {
        var _loc2_ = random(8);
        if(_loc2_ != this.mAngle.__get__mDirection())
        {
            this.mTarget_Angle.__set__mDirection(_loc2_);
            this.SetState("State_Turn");
            return undefined;
        }
        this.SetState("State_CellToCell");
    }
    function State_EnterMap_Init()
    {
        this.SetCollideDirection(this.mPosition,World.Map.CMap_Cell.mCollide_Creature);
        this.mFlags &= Thing.CThing.mFlag_Collidable ^ -1;
        this.mBaseStateID = this.mStateID;
        this.mCurrentCell = this.mNewCell;
        0;
        while(true)
        {
            var _loc3_ = this.mCurrentCell.mAdjacentCells[0];
            if(!(_loc3_ == undefined || _loc3_.mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable))
            {
                this.mAngle.__set__mDirection(0);
                this.mDirectionCell = _loc3_;
                return undefined;
            }
            2;
        }
    }
    function State_EnterMap()
    {
        if(this.mDirectionCell.mCollide & World.Map.CMap_Cell.mCollide_Creature)
        {
            this.SetState("State_Wait");
            return undefined;
        }
        this.Affect_Setup(Thing.Affect.CThing_Affect.mAffect_Bullet | Thing.Affect.CThing_Affect.mAffect_Explosion);
        this.mFlags |= Thing.CThing.mFlag_Collidable;
        this.mBaseStateID = "State_GotoPlayer";
        this.SetState(this.State_RemoveObject != undefined ? "State_RemoveObject" : "State_CellToCell");
    }
    function State_CellToCell_Init()
    {
        this.mDelta = this.mAngle.__get__mDirectionDelta().Clone();
        this.SetCollideDirection(this.mPosition.Add(this.mDelta),World.Map.CMap_Cell.mCollide_Creature);
        this.mStateCount = !(this.mDelta.mX == 0 || this.mDelta.mY == 0) ? 1.4142135623730951 / this.mSpeed : 1 / this.mSpeed;
        this.mDelta = this.mDelta.Add(this.mPosition.__get__mCellCentre().Subtract(this.mPosition)).ScaleN(1 / this.mStateCount);
        this.mXSI_Animation.SetAnimation("walk");
        this.mAnimSpeed = 0.34 * Thing.Creature.CThing_Creature.mAnimationSpeed;
    }
    function State_CellToCell()
    {
        if(--this.mStateCount <= 0)
        {
            this.mPosition.CellCentre();
            this.mMapwho.MoveThing(this);
            this.SetState(this.mBaseStateID);
            return undefined;
        }
        this.mXSI_Animation.QAnimate(this.mAnimSpeed);
        this.mPosition.mX += this.mDelta.mX;
        this.mPosition.mY += this.mDelta.mY;
        !this.mMapwho.MoveThing(this);
    }
    function State_Turn_Init()
    {
        this.mAngleDelta = this.mSpeed * 10 * this.mAngle.TurnAngle(this.mTarget_Angle);
        this.mStateCount = Math.abs(this.mAngle.AngleDifference(this.mTarget_Angle) / this.mAngleDelta);
        this.mXSI_Animation.SetAnimation("stand",0);
    }
    function State_Turn()
    {
        if(--this.mStateCount <= 0)
        {
            this.mAngle.__set__mAngle(this.mTarget_Angle.mAngle);
            this.SetState(this.mBaseStateID);
            return undefined;
        }
        this.mAngle.Add(this.mAngleDelta);
    }
    function State_TurnAndMove_Init()
    {
        this.State_Turn_Init();
    }
    function State_TurnAndMove()
    {
        if(--this.mStateCount <= 0)
        {
            this.mAngle.__set__mAngle(this.mTarget_Angle.mAngle);
            var _loc2_ = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215].CollideFlagsInDirection(this.mAngle.__get__mDirection());
            this.SetState(!(_loc2_ & World.Map.CMap_Cell.mCollide_NonMovable) ? "State_CellToCell" : this.mBaseStateID);
            return undefined;
        }
        this.mAngle.Add(this.mAngleDelta);
    }
    function State_Sleep_Init()
    {
        this.mXSI_Animation.SetAnimation("stand",0);
    }
    function State_Sleep()
    {
        if(--this.mStateCount <= 0)
        {
            this.SetState(this.mReturnStateID);
        }
    }
    function State_Wait_Init()
    {
        this.mStateCount = CMain.mFPS;
        this.mXSI_Animation.SetAnimation("stand",0);
    }
    function State_Wait()
    {
        if(--this.mStateCount <= 0)
        {
            this.SetState(this.mBaseStateID);
        }
    }
    function State_WaitToMove_Init()
    {
        this.mStateCount = CMain.mFPS;
        this.mXSI_Animation.SetAnimation("stand",0);
    }
    function State_WaitToMove()
    {
        if(--this.mStateCount <= 0 || !(this.mCurrentCell.CollideFlagsInDirection(this.mTarget_Direction) & World.Map.CMap_Cell.mCollide_Creature))
        {
            var _loc2_ = this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215].CollideFlagsInDirection(this.mAngle.__get__mDirection());
            this.SetState(!(_loc2_ & World.Map.CMap_Cell.mCollide_NonMovable) ? "State_CellToCell" : this.mBaseStateID);
            return undefined;
        }
    }
    function State_ZombieHit_Init()
    {
        this.State_BulletHit_Init();
    }
    function State_ZombieHit()
    {
        this.State_BulletHit();
    }
    function State_ExplosionHit_Init()
    {
        this.State_BulletHit_Init();
    }
    function State_ExplosionHit()
    {
        this.State_BulletHit();
    }
    function State_BulletHit_Init()
    {
        this.mStateCount = 0;
        var _loc2_ = this.mDelta.__get__mLength();
        while(_loc2_ >= 0.01)
        {
            this.mStateCount++;
            _loc2_ *= 0.65;
        }
        this.mWorld.mMap.mDecal.Draw_BloodSplat(this.mPosition,1);
        this.ClearCollideCell();
        this.mXSI_Animation.SetAnimation("shothit_" + (random(2) + 1),0);
        this.PlaySound(this.mSound.Damage);
        if(this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable)
        {
            this.mDelta.mX = 0;
            this.mDelta.mY = 0;
            this.mDelta.mZ = 0;
        }
    }
    function State_BulletHit()
    {
        var _loc3_ = this.mPosition.Clone();
        var _loc2_ = this.mWorld.mMap.mCollide.CreatureCollide(this);
        if(!isNaN(_loc2_.mX))
        {
            this.Move(_loc2_);
            this.mDelta.ScaleN(0.65);
            if(this.mStateID != "State_ExplosionHit")
            {
                this.mWorld.mMap.mDecal.Draw_BloodSplat(this.mPosition);
            }
            if(this.mLife <= 0)
            {
                this.ClearAffects();
                this.mFlags |= Thing.CThing.mFlag_DEAD;
            }
            if(--this.mStateCount < 0)
            {
                if(this.CheckForDead())
                {
                    return undefined;
                }
                this.mAngle.__set__mAngle(this.mReturn_Angle.mAngle);
                this.SetState("State_Sleep");
                this.mStateCount = 3;
                this.mReturnStateID = this.mBaseStateID;
            }
        }
        this.mFlags |= Thing.CThing.mFlag_DEAD;
        this.mThing_Collection.mThingCounters.INVALIDPOSITION++;
        this.SetState("State_Dying");
        trace("State_BulletHit: New position is invalid = " + _loc2_ + ", old = " + _loc3_);
        return undefined;
    }
    function State_Dying_Init()
    {
        this.PlaySound(this.mSound.Death);
        this.ClearCollideCell();
        this.mFlags &= Thing.CThing.mFlag_Collidable ^ -1;
        this.ClearAffects();
        this.mXSI_Animation.SetAnimation("dying",0);
        this.mStateCount = 0;
        this.mWorld.LogKill(this);
    }
    function State_Dying()
    {
        this.mWorld.mMap.mDecal.Draw_BloodSplat(this.mPosition,1);
        if(this.mXSI_Animation.Animate(0.34 * Thing.Creature.CThing_Creature.mAnimationSpeed))
        {
            this.PlaySound(CSound.mSamples.Creature_HitFloor_wav);
            this.SetState("State_Dead");
        }
    }
    function State_Dead_Init()
    {
        this.mStateCount = this._CLASSID_ != "CThing_Creature_Player" ? CMain.mFPS * 2 : CMain.mFPS * 4;
        this.mFlags |= Thing.CThing.mFlag_SortFloor;
        this.ClearCollideCell();
        this.mXSI_Animation.SetAnimation("dead",0);
        this.mWorld.mMap.mDecal.Draw_BloodSplat(this.mPosition,5);
    }
    function State_Dead()
    {
        this.mAlpha = !(this.mStateCount < CMain.mFPS && _root._quality != "LOW") ? 100 : this.mStateCount / CMain.mFPS * 100;
        if(--this.mStateCount < 0)
        {
            this.Delete();
        }
    }
    function CheckForDead()
    {
        if(this.mLife <= 0 || this.mFlags & Thing.CThing.mFlag_DEAD)
        {
            this.SetState("State_Dying");
            return true;
        }
        return false;
    }
    function SetCollideDirection(p, tCollideFlags)
    {
        this.mNewCell.mCollide &= tCollideFlags ^ -1;
        this.mNewCell_Flags = tCollideFlags;
        this.mNewCell = this.mMap.GetCell(p.mX,p.mY);
        this.mNewCell.mCollide |= this.mNewCell_Flags;
    }
    function ClearCollideCell()
    {
        this.mNewCell.mCollide &= this.mNewCell_Flags ^ -1;
        delete this.mNewCell;
    }
    function QMove()
    {
        this.mMapwho.MoveThing(this);
    }
    function Move(nPosition)
    {
        if(nPosition != this.mPosition)
        {
            this.mPosition.mX = nPosition.mX;
            this.mPosition.mY = nPosition.mY;
            this.mPosition.mZ = nPosition.mZ;
        }
        this.mMapwho.MoveThing(this);
    }
    function MoveAndReturn(nPosition)
    {
        "";
        if(nPosition != this.mPosition)
        {
            if(!nPosition.Equals(this.mPosition))
            {
                "moved";
            }
            this.mPosition.mX = nPosition.mX;
            this.mPosition.mY = nPosition.mY;
            this.mPosition.mZ = nPosition.mZ;
        }
        if(this.mMapwho.MoveThing(this))
        {
            "cellmoved";
        }
        return "cellmoved";
    }
    function ProcessAffects()
    {
        this.mReturn_Angle = this.mAngle.Clone();
        for(var _loc4_ in this.mAffectors)
        {
            var _loc2_ = this.mAffectors[_loc4_];
            switch(_loc2_.mType)
            {
                case Thing.Affect.CThing_Affect.mAffect_Bullet:
                    var _loc3_ = _loc2_.AffectThing(this);
                    this.mStateCount = Math.round(_loc3_ / 5 * 2);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.max(_loc3_ / 5 * 2 / World.Map.CMap_Cell.mSize.x,0.3) / this.mMass);
                    this.mDelta.mZ = 0;
                    this.mAngle.__set__mAngle(this.mDelta.toAngleZ() + 3.141592653589793);
                    this.mHitAngle = _loc2_.mAffector.mAngle;
                    this.SetState("State_BulletHit");
                    break;
                case Thing.Affect.CThing_Affect.mAffect_Push:
                    break;
                case Thing.Affect.CThing_Affect.mAffect_Explosion:
                    _loc3_ = _loc2_.AffectThing(this);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.min(_loc3_ / 5 * 2 / World.Map.CMap_Cell.mSize.x / this.mMass,0.3));
                    this.mDelta.mZ = 0;
                    this.mAngle.__set__mAngle(this.mDelta.toAngleZ() + 3.141592653589793);
                    this.mHitAngle = _loc2_.mAffector.mAngle;
                    this.SetState("State_ExplosionHit");
                    break;
                case Thing.Affect.CThing_Affect.mAffect_ZombieAttack:
                    _loc3_ = _loc2_.AffectThing(this);
                    this.mStateCount = Math.round(_loc3_ / 5);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.max(_loc3_ / 5 / World.Map.CMap_Cell.mSize.x / this.mMass,0.3));
                    this.mDelta.mZ = 0;
                    this.mAngle.__set__mAngle(this.mDelta.toAngleZ() + 3.141592653589793);
                    this.mHitAngle = _loc2_.mAffector.mAngle;
                    this.SetState("State_ZombieHit");
            }
        }
        this.mAffectors = new Array();
    }
}
