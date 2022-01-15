package Landscape
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    public class CLSCtrlCover extends Sprite
    {
         
        
        public var mcMask:MovieClip;
        
        public function CLSCtrlCover()
        {
            super();
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function get _CLASSID_() : String
        {
            return "CLSCtrlCover";
        }
    }
}
