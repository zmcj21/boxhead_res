package Thing
{
    import Draw.CSpriteMCAnimation;
    import Draw.CSpriteMCOmni;
    import World.eWMCCollideType;
    
    public class CThingPeep extends CThingControl
    {
        
        private static var mAllocateProcessID:int = 0;
        
        public static var mXSIList:Object;
        
        public static var mOmniSprite:CSpriteMCOmni;
        
        public static var mSpriteMCAnimation:CSpriteMCAnimation;
        
        private static const mProcessCount:int = 16;
         
        
        public var mDrawBloodOnAffect:Boolean;
        
        public var mDeathClock:int;
        
        public var mAffectThreshold:Number;
        
        public var mInvalid:Boolean;
        
        public const mColor:uint = 4.27819008E9;
        
        public var mMass:Number;
        
        public var fCollide:Function;
        
        public var mAttackScale:Number;
        
        public var mAttackCounter:int;
        
        public function CThingPeep(param1:Object, param2:Class)
        {
            super();
            nProcessID = ++mAllocateProcessID;
            mSeed = nID;
            mAngle = new CThingAngle();
            mAngleTarget = new CThingAngle();
            mCollideRadius = 0.35;
            mCollideHeight = 2.8 * mCollideRadius;
            mSpeedScale = !!param1.mSpeedScale ? Number(param1.mSpeedScale) : Number(1);
            mAttackScale = !!param1.mAttackScale ? Number(param1.mAttackScale) : Number(1);
            mMass = 1;
            mAffectThreshold = 1;
            mAffectFlags = 0 | 0 | 0 | 0 | 0 | 0 | 0;
            mAffectFlags |= 0 | 0;
            AddSound("PEEP_HITFLOOR",Peep_HitFloor,_CLASSID_ == "CBambo" ? 0 : 3,1);
            SetPositionByInitObject(param1);
            MapAdd();
            Process = Process_Normal;
            mAttackCounter = 0;
            mDeathClock = 1.5 * SECONDS;
            fCollide = PeepCollide;
            if(!SpriteSheetExists(_CLASSID_))
            {
                AddSpriteSheet(_CLASSID_,new param2(0,0));
            }
        }
        
        public static function Restart() : void
        {
            mAllocateProcessID = 0;
        }
        
        override public function Dispose() : void
        {
            if(OnDispose != null)
            {
                OnDispose(this);
            }
            super.Dispose();
        }
        
        public function State_NAVIGATE_Enter() : void
        {
            SetBaseState();
        }
        
        public function State_STAND_Enter() : void
        {
            SetAnimation("stand");
        }
        
        public function State_PUSH() : void
        {
            mPosition = PeepCollide();
            MapMove();
            if(--mStateCount < 0)
            {
                if(0 & 0 && !mDead)
                {
                    mLife = -1;
                }
                if(!CheckForDeath())
                {
                    ReturnState_Base();
                }
                return;
            }
            Animate();
        }
        
        public function State_DYING_Enter() : void
        {
            ClearCollide();
            mAffectFlags = 0;
            switch(RandomInt(3))
            {
                case 0:
                    SetAnimation("dying");
                    break;
                case 1:
                    if(SetAnimation("dying_2") == false)
                    {
                        SetAnimation("dying");
                        break;
                    }
                    break;
                case 2:
                    if(SetAnimation("dying_3") == false)
                    {
                        SetAnimation("dying");
                        break;
                    }
            }
            mStateCount = 0;
            Process = Process_Dead;
        }
        
        public function CheckForDeath() : Boolean
        {
            if(mDead)
            {
                if(OnDeath != null)
                {
                    OnDeath(this);
                }
                SetState("State_DYING");
                return true;
            }
            return false;
        }
        
        override public function AnimateEnd(param1:Number = 0.1) : Boolean
        {
            return super.AnimateEnd(param1 * mSpeedScale);
        }
        
        public function State_STAND() : void
        {
        }
        
        override public function Affect_EXPLOSION(param1:CAffect) : void
        {
            var _loc2_:* = null;
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            _loc2_ = mPosition.Clone().Sub(param1.mAffector.mPosition);
            _loc2_.z = 0;
            _loc3_ = param1.mAffector.mCollideRadius + 0.5;
            _loc4_ = Math.max(0.25,Math.min(1,(_loc3_ - _loc2_.mLength) / _loc3_));
            _loc2_.Normalize(_loc4_ * param1.mForce * mMass);
            mLife -= param1.mDamage * _loc4_;
            AffectedAndDead(param1);
            if(mLife < mMaxLife * mAffectThreshold)
            {
                mDelta = _loc2_;
                mAngle.mAngleRAD = NaN;
                SetState("State_HIT",mStateID);
            }
        }
        
        override public function toString() : String
        {
            var _loc1_:* = null;
            _loc1_ = super.toString();
            return _loc1_ + " mAffectFlags:" + mAffectFlags + " mPositon:" + mPosition + " mState:" + mStateID + " mBaseStateID:" + mBaseStateID + " mReturnStateID:" + mReturnStateID + " mStateCount:" + String(mStateCount) + " mLife:" + String(mLife);
        }
        
        public function Process_Dead() : *
        {
            if(mStateID)
            {
                this[mStateID]();
            }
            ProcessChildren();
            mDrawn = false;
        }
        
        public function State_WAITTOMOVE_Exit() : void
        {
        }
        
        public function State_WAIT() : void
        {
            if(--mStateCount < 0)
            {
                ReturnState();
            }
        }
        
        public function State_HIT_Exit() : void
        {
        }
        
        public function State_HIT() : void
        {
            mPosition = fCollide();
            MapMove();
            mDelta.ScaleN(0.45);
            if(true)
            {
                if(0 & 0 && !mDead)
                {
                    mLife = -1;
                }
                if(!CheckForDeath())
                {
                    SetState("State_WAIT",mBaseStateID);
                    mStateCount = 5 * mMass;
                }
                return;
            }
            DrawBlood();
            AnimateEnd();
        }
        
        public function State_STAND_Exit() : void
        {
        }
        
        override public function Affect_ZOMBIEATTACK(param1:CAffect) : void
        {
            Affect_BULLET(param1);
        }
        
        public function State_HIT_Enter() : void
        {
            ClearCollide();
            if(!mDrawn)
            {
                if(!CheckForDeath())
                {
                    SetState("State_WAIT",mBaseStateID);
                }
                return;
            }
            SetAnimation("hit");
        }
        
        override public function Animate(param1:Number = 0.1) : void
        {
            super.Animate(param1 * mSpeedScale);
        }
        
        public function ApplyAffects() : Boolean
        {
            var _loc1_:* = null;
            if(mAffects)
            {
                for each(_loc1_ in mAffects)
                {
                    if(!mDead)
                    {
                        this["Affect_" + _loc1_.mName](_loc1_);
                    }
                }
                mAffects = null;
                return true;
            }
            return false;
        }
        
        public function get mCanProcess() : Boolean
        {
            return true;
        }
        
        public function State_CELLTOCELL() : void
        {
            mPosition.x = NaN;
            mPosition.y = NaN;
            if(mDrawn)
            {
                MapMove();
                Animate();
            }
            if(--mStateCount < 0)
            {
                ReturnState_Base();
            }
        }
        
        public function State_CELLTOCELL_Enter() : void
        {
            if(false)
            {
                SetState("State_TURN",mStateID);
                return;
            }
            mCellTarget = mCellCurrent.mNeighbours["null"];
            if(0 & 0)
            {
                SetState("State_WAIT",mBaseStateID);
                mStateCount = SECONDS * 2;
                return;
            }
            ClearCollide();
            SetCollide(mCellTarget,eWMCCollideType.PEEP);
            mDelta = mAngle.mDelta;
            mDelta.Add(mPosition.mCentre.Sub(mPosition));
            mStateCount = 1 / (mSpeed * mSpeedScale) * (!true ? SQRT2 : 1);
            mDelta.ScaleN(mSpeed * mSpeedScale);
            SetAnimation("walk");
        }
        
        public function Brain() : Boolean
        {
            return false;
        }
        
        public function Process_Normal() : *
        {
            ApplyAffects();
            if(mStateID)
            {
                this[mStateID]();
            }
            ProcessChildren();
            if(mAttackCounter > 0)
            {
                --mAttackCounter;
            }
            if(mInvalid && !mDead)
            {
                mLife = -1;
                CheckForDeath();
            }
            if(mDead)
            {
                SetState("State_DYING");
            }
            mDrawn = false;
        }
        
        override public function Affect_FIRE(param1:CAffect) : void
        {
            Affect_BULLET(param1);
        }
        
        public function State_PUSH_Exit() : void
        {
        }
        
        public function State_TURN_Enter() : void
        {
            mAngleDelta = mAngle.TurnAngle(mAngleTarget);
            mStateCount = mAngleDelta.GetTurnCount(CThingAngle.AsAngle256(128 * (mSpeed * mSpeedScale)));
            mAngleDelta.Scale(1 / mStateCount);
            SetAnimation("stand");
        }
        
        public function State_WAITTOMOVE() : void
        {
            if(--mStateCount < 0)
            {
                ReturnState();
            }
        }
        
        override public function MapMove() : Boolean
        {
            var _loc1_:Boolean = false;
            _loc1_ = super.MapMove();
            if(_loc1_)
            {
                if(0 & 0)
                {
                    mInvalid = true;
                }
            }
            return _loc1_;
        }
        
        override public function get mThingType() : String
        {
            return "PEEP";
        }
        
        override public function Affect_HIT(param1:CAffect) : void
        {
            Affect_BULLET(param1);
        }
        
        public function State_CELLTOCELL_Exit() : void
        {
            MapMove();
        }
        
        public function State_DEAD() : void
        {
            --mStateCount;
            if(mStateCount < 0)
            {
                Dispose();
            }
            else if(mStateCount < 10)
            {
                mAlpha = mStateCount / 10;
            }
        }
        
        override public function Affect_BULLET(param1:CAffect) : void
        {
            var _loc2_:* = null;
            mLife -= param1.mDamage;
            AffectedAndDead(param1);
            if(mLife < mMaxLife * mAffectThreshold)
            {
                _loc2_ = mPosition.Clone().Sub(param1.mAffector.mPosition);
                _loc2_.Normalize(param1.mForce * mMass);
                mAngle.mAngleRAD = _loc2_.mAngleRAD + Math.PI;
                mDelta = _loc2_;
                SetState("State_HIT",mStateID);
            }
        }
        
        public function State_WAIT_Exit() : void
        {
        }
        
        public function State_TURN_Exit() : void
        {
        }
        
        public function QProcess_Normal() : *
        {
            ApplyAffects();
            if(mStateID)
            {
                this[mStateID]();
            }
        }
        
        public function State_NAVIGATE() : void
        {
            if((mAngleTarget = Peep_Navigate_NM()) == null)
            {
                SetState("State_WAIT",mBaseStateID);
                mStateCount = SECONDS * 2;
                return;
            }
            SetState("State_CELLTOCELL");
        }
        
        public function State_WAITTOMOVE_Enter() : void
        {
            SetAnimation("stand");
        }
        
        public function State_TURN() : void
        {
            mAngle.Add(mAngleDelta);
            if(--mStateCount < 0)
            {
                mAngle = mAngleTarget;
                ReturnState();
            }
        }
        
        private function AffectedAndDead(param1:CAffect) : void
        {
            if(mDead)
            {
                mKilledBy = param1.mAffector.AddKill();
                if(mKilledBy)
                {
                }
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingPeep";
        }
        
        public function State_DEAD_Enter() : void
        {
            SetBaseState();
            mStateCount = mDeathClock;
            DrawBlood();
        }
        
        public function State_DYING_Exit() : void
        {
        }
        
        public function State_DYING() : void
        {
            if(++mStateCount > 3)
            {
                if(AnimateEnd(0.14285714285714285))
                {
                    PlaySound("PEEP_HITFLOOR");
                    SetState("State_DEAD");
                }
            }
        }
        
        public function get m_CLASSID_() : String
        {
            return "CThingPeep";
        }
        
        public function State_PUSH_Enter() : void
        {
            ClearCollide();
            if(!mDrawn)
            {
                if(!CheckForDeath())
                {
                    SetState("State_WAIT",mBaseStateID);
                }
                return;
            }
            SetAnimation("walk");
            mStateCount = 2;
        }
        
        override public function Affect_PUSH(param1:CAffect) : void
        {
            mDelta = new CThingV3();
            mAngle.mAngleRAD = mPosition.Clone().Sub(param1.mAffector.mPosition).mAngleRAD + Math.PI;
            SetState("State_PUSH",mStateID);
            mDrawBloodOnAffect = false;
        }
        
        public function State_DEAD_Exit() : void
        {
        }
        
        public function State_WAIT_Enter() : void
        {
            SetAnimation("stand");
        }
        
        public function State_NAVIGATE_Exit() : void
        {
        }
    }
}
