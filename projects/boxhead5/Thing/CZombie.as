package Thing
{
    import World.eWMCCollideType;
    
    public class CZombie extends CThingPeep
    {
        
        private static var firstZombie:CZombie;
         
        
        public function CZombie(param1:Object = null)
        {
            super(param1,SheetZombie);
            mName = "Zombie";
            mSpeed = 0.05;
            mAngle.mDirection = 2;
            SetAnimation("stand");
            SetCollide(mCellCurrent,eWMCCollideType.PEEP);
            mLife = 100;
            mMaxLife = 100;
            mScore = 100;
            mAffectFlags &= -1;
            SetState("State_NAVIGATE");
            Process = QProcess_Normal;
            mName = "Zombie";
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.SpriteSheetExists("CZombie"))
            {
                _loc1_.AddSpriteSheet("CZombie",new SheetZombie(0,0));
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
                return;
            }
            SetAnimation("attack");
        }
        
        override public function State_NAVIGATE() : void
        {
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
            return "CZombie";
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
