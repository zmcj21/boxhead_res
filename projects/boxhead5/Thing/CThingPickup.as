package Thing
{
    public class CThingPickup extends CThingObject
    {
         
        
        private var mPickupCounter:int;
        
        public function CThingPickup(param1:Object, param2:Class)
        {
            param1 = !!param1 ? param1 : new Object();
            param1.mCollideRadius = 0.5;
            param1.mCollideHeight = 0.5;
            param1.mInitState = "State_STAND";
            super(param1);
            if(!SpriteSheetExists(_CLASSID_))
            {
                AddSpriteSheet(_CLASSID_,new param2(0,0));
            }
            SetAnimation("stand");
            mPickupCounter = SECONDS * 15;
            mAffectFlags = eAffectType.FILTER_PICKUP;
        }
        
        public function Pickup(param1:*) : void
        {
            PlaySound("Pickup");
            Dispose();
        }
        
        override public function Process_Normal() : void
        {
            --mPickupCounter;
            if(mPickupCounter < SECONDS)
            {
                mAlpha = mPickupCounter / SECONDS;
            }
            if(mPickupCounter < 0)
            {
                Dispose();
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingPickup";
        }
    }
}
