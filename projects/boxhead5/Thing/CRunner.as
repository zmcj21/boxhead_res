package Thing
{
    import World.eWMCCollideType;
    
    public class CRunner extends CThingPeep
    {
         
        
        public function CRunner(param1:Object = null)
        {
            super(param1,SheetRunner);
            mName = "Runner";
            mSpeed = 0.05;
            mAngle.mDirection = 2;
            SetAnimation("stand");
            SetCollide(mCellCurrent,eWMCCollideType.PEEP);
            mLife = 100;
            mMaxLife = 100;
            mScore = 100;
            SetState("State_NAVIGATE");
            mAffectFlags &= -1;
            mName = "Runner";
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.SpriteSheetExists("CRunner"))
            {
                _loc1_.AddSpriteSheet("CRunner",new SheetRunner(0,0));
            }
            _loc1_.Dispose();
        }
        
        public function State_ATTACK_Exit() : void
        {
        }
        
        public function State_RUNTOTARGET() : void
        {
            mAngle = CThingAngle.AsCThingV3(mTarget.mPosition.Clone().Sub(mPosition));
            mDelta = mAngle.mDelta.ScaleN(mSpeed * mSpeedScale * 2.5);
            mPosition = PeepCollide();
            Animate(defAnimSpeed);
            MapMove();
            if(--mStateCount < 0)
            {
                ReturnState_Base();
                return;
            }
            if(mPosition.Distance2D(mTarget.mPosition) < 1)
            {
                SetState("State_ATTACK");
            }
        }
        
        public function State_ATTACK_Enter() : void
        {
            SetAnimation("attack");
        }
        
        public function State_RUNTOTARGET_Exit() : void
        {
        }
        
        public function State_RUNTOTARGET_Enter() : void
        {
            mAngleTarget = CThingAngle.AsCThingV3(mTarget.mPosition.Clone().Sub(mPosition));
            if(false)
            {
                SetState("State_TURN",mStateID);
                return;
            }
            SetAnimation("run");
            mStateCount = SECONDS * 8;
            ClearCollide();
        }
        
        override public function State_NAVIGATE() : void
        {
            if(!mCanProcess)
            {
                return;
            }
            if(mAttackCounter == 0)
            {
                if(false)
                {
                    if(true)
                    {
                        if(mCellCurrent.mNavTarget.mExists)
                        {
                            mTarget = mCellCurrent.mNavTarget;
                            SetState("State_RUNTOTARGET");
                            return;
                        }
                    }
                }
            }
            super.State_NAVIGATE();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CRunner";
        }
        
        public function State_ATTACK() : void
        {
            mPosition = PeepCollide();
            MapMove();
            if(AnimateEnd(defAnimSpeed * 1.3))
            {
                AffectRadius(CAffect.ZOMBIEATTACK(this,10 * mAttackScale,0.5),100,mAngle.mDelta.ScaleN(mCollideRadius * 2));
                SetState("State_WAIT",mBaseStateID);
                mStateCount = 5;
            }
        }
    }
}
