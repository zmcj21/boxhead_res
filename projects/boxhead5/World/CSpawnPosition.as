package World
{
    public class CSpawnPosition
    {
         
        
        public var mDirection:String;
        
        public var mRandomizer:Number;
        
        public var mCell:CWMCell;
        
        public function CSpawnPosition(param1:CWMCell, param2:String)
        {
            super();
            mCell = param1;
            mDirection = param2;
        }
        
        public function toString() : String
        {
            return mRandomizer.toString();
        }
        
        public function get _CLASSID_() : String
        {
            return "CSpawnPosition";
        }
    }
}
