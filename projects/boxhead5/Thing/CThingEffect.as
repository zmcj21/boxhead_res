package Thing
{
    public class CThingEffect extends CThingCollision
    {
         
        
        public function CThingEffect(param1:*)
        {
            super();
            mAffectFlags = eAffectType.NONE;
            mSeed = nID;
            Inherit(param1);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingEffect";
        }
    }
}
