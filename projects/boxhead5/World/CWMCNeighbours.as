package World
{
    public class CWMCNeighbours extends CWMCBase
    {
        
        public static const mNeighboursDirections8:Array = ["E","SE","S","SW","W","NW","N","NE"];
        
        public static const mNeighboursDirections4:Array = ["E","S","W","N"];
         
        
        public var mNeighbours:Object;
        
        public var nWest:CWMCell;
        
        public var nEast:CWMCell;
        
        public var nNorthWest:CWMCell;
        
        public var nNorthEast:CWMCell;
        
        public var nSouthWest:CWMCell;
        
        public var nSouth:CWMCell;
        
        public var nSouthEast:CWMCell;
        
        public var nNorth:CWMCell;
        
        public function CWMCNeighbours()
        {
            super();
        }
        
        public function SetNeighbours(param1:CWorldMap) : void
        {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            _loc2_ = mapY;
            _loc3_ = mapY - 1;
            _loc4_ = mapY + 1;
            _loc5_ = mapX;
            _loc6_ = mapX - 1;
            _loc7_ = mapX + 1;
            mNeighbours = new Object();
            nEast = mNeighbours["E"] = param1.GetCellAt(_loc7_,_loc2_);
            nSouthEast = mNeighbours["SE"] = param1.GetCellAt(_loc7_,_loc4_);
            nSouth = mNeighbours["S"] = param1.GetCellAt(_loc5_,_loc4_);
            nSouthWest = mNeighbours["SW"] = param1.GetCellAt(_loc6_,_loc4_);
            nWest = mNeighbours["W"] = param1.GetCellAt(_loc6_,_loc2_);
            nNorthWest = mNeighbours["NW"] = param1.GetCellAt(_loc6_,_loc3_);
            nNorth = mNeighbours["N"] = param1.GetCellAt(_loc5_,_loc3_);
            nNorthEast = mNeighbours["NE"] = param1.GetCellAt(_loc7_,_loc3_);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMCNeighbours";
        }
    }
}
