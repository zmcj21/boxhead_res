package Thing
{
    public class CThingMain extends CThingAffect
    {
         
        
        public var mThingsByType:Object;
        
        public var mThingCounters:Object;
        
        public function CThingMain()
        {
            super();
            mSeed = nID;
            mThingCounters = new Object();
            mThingsByType = new Object();
        }
        
        override public function RemoveThing(param1:*) : *
        {
            mThingsByType[param1.mThingType].splice(mThingsByType[param1.mThingType].indexOf(param1),1);
            return super.RemoveThing(param1);
        }
        
        override public function AddThing(param1:*) : *
        {
            if(false)
            {
                mThingsByType[param1.mThingType].push(param1);
            }
            else
            {
                mThingsByType[param1.mThingType] = [param1];
            }
            return super.AddThing(param1);
        }
        
        override public function ProcessChildren() : Boolean
        {
            var _loc1_:* = null;
            var _loc2_:* = undefined;
            if(!mThings)
            {
                return false;
            }
            for(_loc1_ in mThingsByType)
            {
                for each(_loc2_ in mThingsByType[_loc1_])
                {
                    if(_loc2_.Process)
                    {
                        _loc2_.Process();
                    }
                }
            }
            return true;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingMain";
        }
    }
}
