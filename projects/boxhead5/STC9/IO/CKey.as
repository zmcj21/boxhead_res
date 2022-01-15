package STC9.IO
{
    import flash.utils.getTimer;
    
    public class CKey
    {
        
        static var mNumberOfSamples:Number = 30;
         
        
        public var mReleased:int;
        
        public var mPressed:int;
        
        public var mDown:Boolean;
        
        public var mKeyCode:int;
        
        public function CKey(param1:Number)
        {
            super();
            mKeyCode = param1;
        }
        
        public function get _CLASSID_() : String
        {
            return "CKey";
        }
        
        public function Clear() : void
        {
            mDown = false;
            mPressed = 0;
            mReleased = 0;
        }
        
        public function RegisterAsUp() : *
        {
            if(mDown)
            {
                mDown = false;
                mReleased = getTimer();
            }
        }
        
        public function RegisterAsDown() : *
        {
            if(!mDown)
            {
                mDown = true;
                mPressed = getTimer();
            }
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CKey";
        }
    }
}
