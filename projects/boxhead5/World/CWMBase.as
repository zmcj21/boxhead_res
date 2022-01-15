package World
{
    public class CWMBase
    {
         
        
        public var xCells:Array;
        
        public var mCells:Array;
        
        public var mHeight1:uint;
        
        public var mHeight:uint;
        
        public var dumbCell:CWMCell;
        
        public var mWidth1:uint;
        
        public var mWidth:uint;
        
        public var mAllCells:Array;
        
        public function CWMBase()
        {
            super();
        }
        
        public function get _CLASSID_() : String
        {
            return "CWMBase";
        }
    }
}
