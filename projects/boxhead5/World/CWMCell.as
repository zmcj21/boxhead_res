package World
{
    public class CWMCell extends CWMCNavigation
    {
        
        public static const MAPWHOCHANGE:String = "COLLIDECHANGE";
         
        
        private var mMonitors:Object;
        
        public function CWMCell(param1:int, param2:int)
        {
            super();
            mapX = param1;
            mapY = param2;
            nID = mapY << 16 | mapX;
            sID = "WMC" + nID.toString(16);
            mMapwho = new Object();
            mMapwhoCount = 0;
            mMonitors = new Object();
        }
        
        public function RemoveMonitor(param1:String) : void
        {
            delete mMonitors[param1];
        }
        
        public function RemoveThing(param1:*) : void
        {
            --mMapwhoCount;
            delete mMapwho[param1.mID];
        }
        
        public function AddMonitor(param1:String, param2:Object) : void
        {
            mMonitors[param1] = param2;
            mMonitors[param1][sID] = this;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMCell";
        }
        
        public function AddThing(param1:*) : void
        {
            var _loc2_:* = null;
            mMapwho[param1.mID] = param1;
            ++mMapwhoCount;
            for each(_loc2_ in mMonitors)
            {
                _loc2_[sID] = this;
            }
        }
    }
}
