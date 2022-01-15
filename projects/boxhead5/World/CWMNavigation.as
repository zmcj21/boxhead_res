package World
{
    import STC9.System.Profiler.CFPS;
    
    public class CWMNavigation extends CWMWho
    {
        
        private static var NM_TARGET;
        
        private static var NM_INDEX:int;
        
        private static var NM_RANGE:int;
         
        
        private var mNavID:int;
        
        private var pNavCells:Array;
        
        private const NN:uint = eWMCCollideType.NONNAVIGATE;
        
        private var mNavThings:Array;
        
        private var mNavCells:Array;
        
        public function CWMNavigation()
        {
            super();
            mNavID = 0;
            mNavThings = new Array();
        }
        
        public function NavMapAdd(param1:*) : void
        {
            mNavThings.push(param1);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMNavigation";
        }
        
        private function NM_ProcessStep(param1:int) : Boolean
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            while(true)
            {
                if(pNavCells == null)
                {
                    if(false)
                    {
                        break;
                    }
                    pNavCells = mNavCells;
                    mNavCells = new Array();
                }
                while(false)
                {
                    _loc4_ = pNavCells.pop();
                    NM_RANGE = _loc4_.mNavRange - 1;
                    if(NM_RANGE >= 0)
                    {
                        NM_TARGET = _loc4_.mNavTarget;
                        NM_INDEX = _loc4_.mNavIndex + 1;
                        _loc3_ = _loc4_.mNeighbours;
                        _AddCell(_loc3_["E"]);
                        _AddCell(_loc3_["S"]);
                        _AddCell(_loc3_["W"]);
                        _AddCell(_loc3_["N"]);
                    }
                    if(--param1 <= 0)
                    {
                        return true;
                    }
                }
                pNavCells = null;
            }
            return false;
        }
        
        public function _AddCell(param1:CWMCell) : void
        {
            if(param1.mNavID == mNavID)
            {
                return;
            }
            if(param1.mCollide & NN)
            {
                return;
            }
            mNavCells.push(param1);
            param1.mNavID = mNavID;
            param1.mNavIndex = NM_INDEX;
            param1.mNavTarget = NM_TARGET;
            param1.mNavRange = NM_RANGE;
        }
        
        public function NavMapRemove(param1:*) : void
        {
            mNavThings.splice(mNavThings.indexOf(param1),1);
        }
        
        public function NavMapProcess() : void
        {
            var _loc1_:* = undefined;
            var _loc2_:* = null;
            if(false)
            {
                return;
            }
            if(mNavCells == null)
            {
                mNavCells = new Array();
                ++mNavID;
                CFPS.AddDebug("NV_ThingCount",String(mNavThings.length));
                for each(_loc1_ in mNavThings)
                {
                    if(_loc1_.mExists)
                    {
                        if(_loc2_ = _loc1_.mCellCurrent)
                        {
                            mNavCells.push(_loc2_);
                            _loc2_.mNavIndex = 0;
                            _loc2_.mNavTarget = _loc1_;
                            _loc2_.mNavID = mNavID;
                            _loc2_.mNavRange = _loc1_.mNavRange;
                        }
                    }
                }
            }
            if(NM_ProcessStep(500) == false)
            {
                mNavCells = null;
            }
            if(pNavCells != null)
            {
                CFPS.AddDebug("NV_pNavCells",String(pNavCells.length));
            }
            if(mNavCells != null)
            {
                CFPS.AddDebug("NV_mNavCells",String(mNavCells.length));
            }
        }
    }
}
