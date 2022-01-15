package Thing
{
    import World.CWMCell;
    import World.eWMCCollideType;
    
    public class CVampire extends CThingPeep
    {
         
        
        private var mReappearCell:CWMCell;
        
        public function CVampire(param1:Object = null)
        {
            super(param1,SheetVampire);
            mName = "Vampire";
            mSpeed = 0.06;
            mAngle.mDirection = 2;
            SetAnimation("stand");
            SetCollide(mCellCurrent,eWMCCollideType.PEEP);
            mLife = 100;
            mMaxLife = 100;
            mScore = 100;
            SetState("State_NAVIGATE");
            mAffectFlags &= -1;
            AddSound("Disappear",Vampire_Disappear,2);
            mName = "Vampire";
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.SpriteSheetExists("CVampire"))
            {
                _loc1_.AddSpriteSheet("CVampire",new SheetVampire(0,0));
            }
            _loc1_.Dispose();
        }
        
        public function State_DISAPPEAR_Exit() : void
        {
            mAlpha = 1;
        }
        
        public function State_ATTACK_Exit() : void
        {
        }
        
        public function State_REAPPEAR_Exit() : void
        {
            mAlpha = 1;
        }
        
        public function State_REAPPEAR_Enter() : void
        {
            mPosition = new CThingV3(NaN,NaN,0);
            mAngle = CThingAngle.AsXY(NaN,NaN);
            SetAnimation("stand");
            AddThing(new CAppearSmoke(this,new CThingV3(0,0,mCollideHeight / 2)));
            MapMove();
        }
        
        public function State_ATTACK_Enter() : void
        {
            SetAnimation("attack");
        }
        
        public function State_DISAPPEAR() : void
        {
            mAlpha -= 0.2;
            if(mAlpha <= 0)
            {
                SetState("State_REAPPEAR");
                mAlpha = 0;
            }
        }
        
        public function State_DISAPPEAR_Enter() : void
        {
            ClearCollide();
            SetCollide(mReappearCell,eWMCCollideType.PEEP);
            SetAnimation("stand");
            AddThing(new CAppearSmoke(this,new CThingV3(0,0,mCollideHeight / 2)));
            PlaySound("Disappear");
            mAlpha = 1;
        }
        
        override public function State_NAVIGATE() : void
        {
            var _loc1_:Number = NaN;
            var _loc2_:* = null;
            if(!mCanProcess)
            {
                return;
            }
            if(true)
            {
                if(mTarget = mCellCurrent.mNavTarget)
                {
                    if(false)
                    {
                        if(true)
                        {
                            if(mCellTarget = mCellCurrent.GetNavIndex0())
                            {
                                if(DistanceToCell(mCellTarget) < NaN)
                                {
                                    mAngleTarget = CThingAngle.AsXY(0 - 0,0 - 0);
                                    if(false)
                                    {
                                        SetState("State_TURN",mStateID);
                                        return;
                                    }
                                    SetState("State_ATTACK");
                                    return;
                                }
                            }
                        }
                        else if(!mAttackCounter)
                        {
                            mCellTarget = mTarget.mCellCurrent;
                            if(mCellTarget != null)
                            {
                                _loc1_ = DistanceToCell(mCellTarget);
                                if(_loc1_ > 6 && _loc1_ < 10)
                                {
                                    _loc2_ = mCellTarget.MovableNeighbours4(false);
                                    if(_loc2_.length != 0)
                                    {
                                        mReappearCell = _loc2_[RandomInt(_loc2_.length)];
                                        SetState("State_DISAPPEAR");
                                        mAttackCounter = SECONDS * 5;
                                        return;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            super.State_NAVIGATE();
        }
        
        public function State_REAPPEAR() : void
        {
            if(mTarget)
            {
                mAngle.mAngleRAD = mPosition.GetAngle(mTarget.mPosition);
            }
            mAlpha += 0.2;
            if(mAlpha >= 1)
            {
                SetState("State_ATTACK");
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CVampire";
        }
        
        public function State_ATTACK() : void
        {
            if(mTarget)
            {
                mAngle.mAngleRAD = mPosition.GetAngle(mTarget.mPosition);
            }
            if(AnimateEnd())
            {
                AffectCell(CAffect.ZOMBIEATTACK(this,20 * mAttackScale,0.5),mCellTarget,100);
                SetState("State_WAIT",mBaseStateID);
                mStateCount = 5;
            }
        }
    }
}
