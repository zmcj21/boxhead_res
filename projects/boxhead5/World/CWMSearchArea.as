package World
{
    public class CWMSearchArea
    {
        
        public static var mWidth1:uint;
        
        public static var mHeight1:uint;
         
        
        public var valid:Boolean;
        
        public var bottom:uint;
        
        public var left:uint;
        
        public var top:uint;
        
        public var right:uint;
        
        public function CWMSearchArea(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            super();
            if(param1 > mWidth1 || param1 + param3 < 0 || param2 > mHeight1 || param2 + param4 < 0)
            {
                valid = false;
                return;
            }
            valid = true;
            left = param1 < 0 ? 0 : uint(param1);
            top = param2 < 0 ? 0 : uint(param2);
            right = param1 + param3 > mWidth1 ? uint(mWidth1) : uint(param1 + param3);
            bottom = param2 + param4 > mHeight1 ? uint(mHeight1) : uint(param2 + param4);
        }
        
        public function get _CLASSID_() : String
        {
            return "CWMSearchArea";
        }
    }
}
