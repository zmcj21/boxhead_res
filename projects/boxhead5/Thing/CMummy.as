package Thing
{
    import World.eWMCCollideType;
    
    public class CMummy extends CThingPeep
    {
         
        
        public function CMummy(param1:Object = null)
        {
            super(param1,SheetMummy);
            mName = "Mummy";
            mSpeed = 0.04;
            mAngle.mDirection = 2;
            SetAnimation("stand");
            SetCollide(mCellCurrent,eWMCCollideType.PEEP);
            mLife = 100;
            mMaxLife = 100;
            mScore = 100;
            SetState("State_NAVIGATE");
            mAffectFlags &= -1;
            mName = "Mummy";
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.SpriteSheetExists("CMummy"))
            {
                _loc1_.AddSpriteSheet("CMummy",new SheetMummy(0,0));
            }
            _loc1_.Dispose();
        }
        
        public function State_ATTACK_Exit() : void
        {
        }
        
        public function State_ATTACK_Enter() : void
        {
            if(false)
            {
                SetState("State_TURN",mStateID);
            }
            else
            {
                SetAnimation("attack");
            }
        }
        
        override public function State_NAVIGATE() : void
        {
            if(!mCanProcess)
            {
                return;
            }
            if(false)
            {
                if(true)
                {
                    if(mCellCurrent.mNavTarget.mExists)
                    {
                        if(mCellTarget = mCellCurrent.GetNavIndex0())
                        {
                            if(DistanceToCell(mCellTarget) < NaN)
                            {
                                mAngleTarget = CThingAngle.AsXY(0 - 0,0 - 0);
                                SetState("State_ATTACK");
                                return;
                            }
                        }
                    }
                }
            }
            super.State_NAVIGATE();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMummy";
        }
        
        public function State_ATTACK() : void
        {
            if(AnimateEnd())
            {
                AffectCell(CAffect.ZOMBIEATTACK(this,10 * mAttackScale,0.5),mCellTarget,100);
                SetState("State_WAIT",mBaseStateID);
                mStateCount = 5;
            }
        }
    }
}
