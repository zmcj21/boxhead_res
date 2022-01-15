package World
{
    public class CWorldMap extends CWMNavigation
    {
         
        
        public function CWorldMap(param1:Array)
        {
            super();
            CreateCells(param1);
            CWMSearch.CreateLineSearches();
        }
        
        public function CreateCells(param1:Array) : void
        {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:* = null;
            var _loc6_:* = null;
            mWidth = param1[0].length;
            mHeight = param1.length;
            mWidth1 = mWidth - 1;
            mHeight1 = mHeight - 1;
            mCells = new Array();
            mAllCells = new Array();
            _loc4_ = 0;
            while(_loc4_ < mHeight)
            {
                _loc3_ = 0;
                _loc5_ = mCells[_loc4_] = new Array();
                while(_loc3_ < mWidth)
                {
                    (_loc6_ = new CWMCell(_loc3_,_loc4_)).mCollide = param1[_loc4_][_loc3_].mCollide;
                    _loc5_.push(_loc6_);
                    mAllCells.push(_loc6_);
                    _loc3_++;
                }
                _loc4_++;
            }
            dumbCell = new CWMCell(0,0);
            dumbCell.mCollide = 0 | 0;
            for each(_loc2_ in mAllCells)
            {
                _loc2_.SetNeighbours(this);
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWorldMap";
        }
        
        public function Process() : void
        {
            CWMSearchArea.mWidth1 = mWidth1;
            CWMSearchArea.mHeight1 = mHeight1;
        }
    }
}
