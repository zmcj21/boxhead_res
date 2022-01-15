package Thing
{
    public class CThingShot extends CThingCollision
    {
         
        
        public var mShotDestination:CThingV3;
        
        public function CThingShot(param1:*, param2:CAffect = null)
        {
            super();
            mAffectFlags = eAffectType.NONE;
            mSeed = nID;
            mAffect = param2;
            Inherit(param1);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingShot";
        }
    }
}
