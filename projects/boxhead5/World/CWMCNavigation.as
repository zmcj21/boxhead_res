package World
{
    import Thing.CThing;
    
    public class CWMCNavigation extends CWMCNeighbours
    {
        
        public static const bSW:int = 8;
        
        public static const COLLIDEINDEX:int = eWMCCollideType.EDGE;
        
        public static const COLLIDEINDEXp1:int = NaN;
        
        public static const SEARCHES:Object = {
            "E":["E","NE","SE","N","S","NW","SW","W"],
            "SE":["SE","E","S","SW","NE","W","N","NW"],
            "S":["S","SW","SE","W","E","NW","NE","N"],
            "SW":["SW","W","S","NW","SE","E","N","NE"],
            "W":["W","SW","NW","S","N","NE","SE","E"],
            "NW":["NW","W","N","SW","NE","S","E","SE"],
            "N":["N","NE","NW","E","W","SE","SW","S"],
            "NE":["NE","N","E","NW","SE","W","S","SW"]
        };
        
        public static const bNE:int = 128;
        
        public static const bE:int = 1;
        
        public static const bNW:int = 32;
        
        public static const bN:int = 64;
        
        public static const bN_E:int = bE | bN;
        
        public static const bS:int = 4;
        
        public static const bSE:int = 2;
        
        public static const bW:int = 16;
        
        public static const bS_W:int = bW | bS;
        
        public static const bESNW:int = bE | bS | bN | bW;
        
        public static const bN_W:int = bW | bN;
        
        public static const bS_E:int = bE | bS;
        
        private static var moveBits:int;
         
        
        public var mNavID:int;
        
        public var mNavTarget;
        
        public var mNavRange:int;
        
        public var mNavIndex:int;
        
        public function CWMCNavigation()
        {
            super();
            mNavIndex = 1000000;
            mNavID = 0;
            mNavRange = 0;
        }
        
        public function CanMove_1(param1:String) : Boolean
        {
            var _loc2_:* = null;
            _loc2_ = mNeighbours[param1];
            if(_loc2_.mCollide > COLLIDEINDEX)
            {
                return false;
            }
            return _loc2_.mNavIndex < mNavIndex;
        }
        
        public function CanMove_2(param1:String) : Boolean
        {
            var _loc2_:* = null;
            if(mNeighbours[param1.charAt(0)].mCollide > COLLIDEINDEX)
            {
                return false;
            }
            if(mNeighbours[param1.charAt(1)].mCollide > COLLIDEINDEX)
            {
                return false;
            }
            _loc2_ = mNeighbours[param1];
            if(_loc2_.mCollide > COLLIDEINDEX)
            {
                return false;
            }
            return _loc2_.mNavIndex < mNavIndex;
        }
        
        public function MovableNeighbours8_1(param1:String, param2:Boolean = true) : CWMCNavigation
        {
            var _loc3_:int = 0;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            moveBits = 0;
            if(nEast.mCollide < COLLIDEINDEXp1)
            {
                moveBits |= bE;
            }
            if(nSouth.mCollide < COLLIDEINDEXp1)
            {
                moveBits |= bS;
            }
            if(nWest.mCollide < COLLIDEINDEXp1)
            {
                moveBits |= bW;
            }
            if(nNorth.mCollide < COLLIDEINDEXp1)
            {
                moveBits |= bN;
            }
            if(false)
            {
            }
            if(moveBits == 0)
            {
                return null;
            }
            if(false)
            {
            }
            _loc3_ = mNavIndex;
            _loc4_ = null;
            for each(_loc5_ in SEARCHES[param1])
            {
                if((_loc6_ = mNeighbours[_loc5_]).mNavIndex <= _loc3_)
                {
                    if(this["CanMove_" + _loc5_]())
                    {
                        _loc3_ = _loc6_.mNavIndex;
                        if(mNavIndex - _loc3_ >= 1)
                        {
                            if(false)
                            {
                            }
                            return _loc6_;
                        }
                        _loc4_ = _loc6_;
                    }
                }
            }
            if(false)
            {
            }
            return _loc4_;
        }
        
        public function GetNavIndex0() : CWMCell
        {
            var _loc1_:* = null;
            for each(_loc1_ in mNeighbours)
            {
                if(_loc1_.mNavIndex == 0)
                {
                    return _loc1_;
                }
            }
            return null;
        }
        
        public function CanMove(param1:String) : Boolean
        {
            if(param1.length == 1)
            {
                return CanMove_1(param1);
            }
            return CanMove_2(param1);
        }
        
        private function CanMove_NE() : Boolean
        {
            return nNorthEast.mCollide < COLLIDEINDEXp1 && moveBits & bN_E;
        }
        
        private function CanMove_E() : int
        {
            return moveBits & bE;
        }
        
        private function CanMove_N() : int
        {
            return moveBits & bN;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMCNavigation";
        }
        
        private function CanMove_S() : int
        {
            return moveBits & bS;
        }
        
        private function CanMove_NW() : Boolean
        {
            return nNorthWest.mCollide < COLLIDEINDEXp1 && moveBits & bN_W;
        }
        
        private function CanMove_W() : int
        {
            return moveBits & bW;
        }
        
        private function CanMove_SE() : Boolean
        {
            return nSouthEast.mCollide < COLLIDEINDEXp1 && moveBits & bS_E;
        }
        
        private function CanMove_SW() : Boolean
        {
            return nSouthWest.mCollide < COLLIDEINDEXp1 && moveBits & bS_W;
        }
        
        private function SortOnNavIndex(param1:CWMCNavigation, param2:CWMCNavigation) : Number
        {
            return param1.mNavIndex > param2.mNavIndex ? 1 : (param1.mNavIndex < param2.mNavIndex ? -1 : Number(0));
        }
        
        public function MovableNeighbours4(param1:Boolean = true) : Array
        {
            var _loc2_:* = null;
            _loc2_ = new Array();
            if(nEast.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nEast);
            }
            if(nWest.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nWest);
            }
            if(nSouth.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nSouth);
            }
            if(nNorth.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nNorth);
            }
            if(param1 && _loc2_.length)
            {
                _loc2_.sort(SortOnNavIndex);
            }
            return _loc2_;
        }
        
        public function MovableNeighbours8(param1:Boolean = true) : Array
        {
            var _loc2_:* = null;
            var _loc3_:* = false;
            var _loc4_:* = false;
            _loc2_ = new Array();
            _loc3_ = nEast.mCollide <= COLLIDEINDEX;
            _loc4_ = nWest.mCollide <= COLLIDEINDEX;
            if(_loc3_)
            {
                _loc2_.push(nEast);
            }
            if(_loc4_)
            {
                _loc2_.push(nWest);
            }
            if(nSouth.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nSouth);
                if(nSouthEast.mCollide <= COLLIDEINDEX && _loc3_)
                {
                    _loc2_.push(nSouthEast);
                }
                if(nSouthWest.mCollide <= COLLIDEINDEX && _loc4_)
                {
                    _loc2_.push(nSouthWest);
                }
            }
            if(nNorth.mCollide <= COLLIDEINDEX)
            {
                _loc2_.push(nNorth);
                if(nNorthEast.mCollide <= COLLIDEINDEX && _loc3_)
                {
                    _loc2_.push(nNorthEast);
                }
                if(nNorthWest.mCollide <= COLLIDEINDEX && _loc4_)
                {
                    _loc2_.push(nNorthWest);
                }
            }
            if(param1 && _loc2_.length)
            {
                _loc2_.sort(SortOnNavIndex);
            }
            return _loc2_;
        }
    }
}
