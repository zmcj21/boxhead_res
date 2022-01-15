package Thing
{
    import World.eWMCCollideType;
    
    public class CThingStatic extends CThingAffect
    {
         
        
        private var mGrowCollideRadius:Number;
        
        public function CThingStatic()
        {
            super();
        }
        
        public function State_STAND_Enter() : void
        {
        }
        
        public function State_STAND() : void
        {
        }
        
        public function State_GROWRADIUS_Enter() : void
        {
            SetAnimation("stand");
            mGrowCollideRadius = mCollideRadius;
            mCollideRadius = 0;
            mAffectFlags &= -1;
        }
        
        public function State_STAND_Exit() : void
        {
        }
        
        public function State_GROWRADIUS() : void
        {
            if(0 & 0)
            {
                return;
            }
            if(GrowRadius(mGrowCollideRadius))
            {
                mCollideRadius = mGrowCollideRadius;
                mAffectFlags |= 0;
                if(!ReturnState())
                {
                    SetState("State_STAND");
                }
            }
        }
        
        public function State_GROWRADIUS_Exit() : void
        {
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingStatic";
        }
    }
}
